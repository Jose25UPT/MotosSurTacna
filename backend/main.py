from fastapi.responses import FileResponse
import subprocess
import zipfile
import datetime

# --- IMPORTS ---
from fastapi import FastAPI, HTTPException, Body, Request, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel, Field
from typing import Any, Dict, List
import psycopg2
import psycopg2.extras
import os
import shutil
import uuid
from pathlib import Path
import time

# --- CONEXIÓN DB CON REINTENTOS ---
def get_db_connection():
    max_retries = 3
    retry_delay = 1
    
    for attempt in range(max_retries):
        try:
            conn = psycopg2.connect(
                host=os.environ.get("POSTGRES_HOST", "db"),
                database=os.environ.get("POSTGRES_DB", "tienda_motos"),
                user=os.environ.get("POSTGRES_USER", "postgres"),
                password=os.environ.get("POSTGRES_PASSWORD", "postgres"),
                port=os.environ.get("POSTGRES_PORT", 5432),
                connect_timeout=10,
                application_name="motossur_backend"
            )
            # Verificar que la conexión funciona
            with conn.cursor() as cursor:
                cursor.execute("SELECT 1")
                cursor.fetchone()
            return conn
        except psycopg2.OperationalError as e:
            print(f"[DEBUG] Error de conexión BD (intento {attempt + 1}/{max_retries}): {e}")
            if attempt < max_retries - 1:
                time.sleep(retry_delay)
                retry_delay *= 2  # Backoff exponencial
            else:
                raise e
        except Exception as e:
            print(f"[DEBUG] Error inesperado en conexión BD: {e}")
            raise e

# --- APP FASTAPI ---
# --- APP FASTAPI ---
app = FastAPI()

# --- BACKUP ENDPOINT ---
@app.get("/backup")
def download_backup():
    """
    Genera un backup de la base de datos y la carpeta uploads en un zip descargable.
    """
    # 1. Backup SQL
    fecha = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    sql_file = f"backup_tienda_motos_{fecha}.sql"
    zip_file = f"backup_tienda_motos_{fecha}.zip"
    db_name = os.environ.get("POSTGRES_DB", "tienda_motos")
    db_user = os.environ.get("POSTGRES_USER", "postgres")
    db_host = os.environ.get("POSTGRES_HOST", "db")
    db_port = os.environ.get("POSTGRES_PORT", "5432")
    
    # Ejecutar pg_dump
    try:
        result = subprocess.run([
            "pg_dump",
            f"-h{db_host}",
            f"-U{db_user}",
            f"-p{db_port}",
            db_name
        ], capture_output=True, text=True, check=True, env={**os.environ, "PGPASSWORD": os.environ.get("POSTGRES_PASSWORD", "postgres")})
        with open(sql_file, "w", encoding="utf-8") as f:
            f.write(result.stdout)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error al generar backup SQL: {e}")

    # 2. Comprimir uploads y SQL en un zip
    try:
        with zipfile.ZipFile(zip_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
            # Agregar SQL
            zipf.write(sql_file)
            # Agregar carpeta uploads
            uploads_root = Path("uploads")
            for folder, _, files in os.walk(uploads_root):
                for file in files:
                    file_path = Path(folder) / file
                    zipf.write(file_path, file_path.relative_to("."))
    except Exception as e:
        # Limpiar archivo sql si falla
        if os.path.exists(sql_file):
            os.remove(sql_file)
        raise HTTPException(status_code=500, detail=f"Error al comprimir backup: {e}")

    # 3. Limpiar archivo sql
    if os.path.exists(sql_file):
        os.remove(sql_file)

    # 4. Retornar zip como descarga
    return FileResponse(zip_file, filename=zip_file, media_type='application/zip')

# Crear directorio de uploads si no existe
UPLOAD_DIR = Path("uploads/motos")
UPLOAD_DIR.mkdir(parents=True, exist_ok=True)

# Servir archivos estáticos
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- MODELOS ---
class MotoCreate(BaseModel):
    brand: str
    model: str
    year: int
    engine: str = "N/A"
    displacement: str = "N/A"
    power: str = "N/A"
    price_soles: float
    style: str = "N/A"
    transmission: str = "N/A"
    image_url: str
    color: str = "N/A"
    description: str = "N/A"
    is_active: bool = True
    specs: dict = {}
    gallery: list = []
    brand_info: str = None

# --- ENDPOINTS ---

# Endpoint para subir archivos
@app.post("/upload")
async def upload_file(file: UploadFile = File(...)):
    try:
        # Validar tipo de archivo
        valid_types = ["image/jpeg", "image/jpg", "image/png", "image/webp", "image/avif"]
        if file.content_type not in valid_types:
            raise HTTPException(
                status_code=400, 
                detail="Tipo de archivo no válido. Solo se permiten: JPG, PNG, WEBP, AVIF"
            )
        
        # Validar tamaño (máximo 5MB)
        file_size = 0
        content = await file.read()
        file_size = len(content)
        
        if file_size > 5 * 1024 * 1024:  # 5MB
            raise HTTPException(status_code=400, detail="El archivo es demasiado grande. Máximo 5MB")
        
        # Generar nombre único
        file_extension = Path(file.filename).suffix
        unique_filename = f"{uuid.uuid4()}{file_extension}"
        
        # Guardar archivo
        file_path = UPLOAD_DIR / unique_filename
        with open(file_path, "wb") as buffer:
            buffer.write(content)
        
        # Retornar ruta relativa
        relative_path = f"/uploads/motos/{unique_filename}"
        
        return {
            "success": True,
            "message": "Imagen subida exitosamente",
            "imagePath": relative_path
        }
        
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail="Error interno del servidor")

@app.post("/motos")
def create_moto(moto: MotoCreate):
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            # 1. Insertar primero la moto principal (sin specs)
            cursor.execute(
                """
                INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                RETURNING id
                """,
                (
                    moto.brand, moto.model, moto.year, moto.engine, moto.displacement, moto.power,
                    moto.price_soles, moto.style, moto.transmission, moto.image_url, moto.color,
                    moto.description, moto.is_active
                )
            )
            moto_id = cursor.fetchone()["id"]

            # 2. Preparar specs y galería
            specs = moto.specs or {}
            gallery = moto.gallery
            if isinstance(gallery, str):
                import json
                try:
                    gallery = json.loads(gallery)
                except Exception:
                    gallery = [gallery]
            if not isinstance(gallery, list):
                gallery = [str(gallery)]
            gallery = [str(x) for x in gallery if x]
            if moto.image_url and moto.image_url not in gallery:
                gallery.insert(0, moto.image_url)

            # 3. Insertar specs (solo si hay algún dato o galería)
            if specs or gallery:
                cursor.execute(
                    """
                    INSERT INTO motorcycle_specs (
                        motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed, max_torque, brakes, fuel_capacity, tires, start_type, tank, dashboard, ohc, digital_dashboard, alarm, ignition, usb, led_lights, gearbox, gallery
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """,
                    (
                        moto_id,
                        specs.get("suspension"), specs.get("telescopic_forks"), specs.get("length"), specs.get("width"), specs.get("height"),
                        specs.get("max_speed"), specs.get("max_torque"), specs.get("brakes"), specs.get("fuel_capacity"), specs.get("tires"),
                        specs.get("start_type"), specs.get("tank"), specs.get("dashboard"), specs.get("ohc"), specs.get("digital_dashboard"),
                        specs.get("alarm"), specs.get("ignition"), specs.get("usb"), specs.get("led_lights"), specs.get("gearbox"), gallery
                    )
                )

            # 4. Normalizar brand_info
            normalized_brand = moto.brand.strip().capitalize()
            about = moto.brand_info if moto.brand_info else "N/A"
            cursor.execute(
                """
                INSERT INTO brand_info (brand, about) VALUES (%s, %s)
                ON CONFLICT (brand) DO UPDATE SET about = EXCLUDED.about
                """,
                (normalized_brand, about)
            )
            if normalized_brand != moto.brand:
                cursor.execute("UPDATE motorcycles SET brand=%s WHERE id=%s", (normalized_brand, moto_id))

            conn.commit()
            return {"id": moto_id, **moto.dict(), "gallery": gallery}
    finally:
        conn.close()
# El siguiente bloque estaba fuera de cualquier función y con indentación incorrecta.
# Si se provee info de la marca, actualizar brand_info
# if data.get("brand_info"):
#     cursor.execute(
#         """
#         INSERT INTO brand_info (brand, about) VALUES (%s, %s)
#         ON CONFLICT (brand) DO UPDATE SET about = EXCLUDED.about
#         """,
#         (data.get("brand"), data.get("brand_info"))
#     )
# conn.commit()
# return {"id": moto_id, **data, "specs": specs}
# finally:
#     conn.close()

@app.get("/motos")
def get_motos():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute("SELECT * FROM motorcycles")
            motos = cursor.fetchall()
            motos_mapeadas = []
            for m in motos:
                mapeada = dict(m)
                # Especificaciones técnicas completas
                cursor.execute("SELECT * FROM motorcycle_specs WHERE motorcycle_id = %s", (m["id"],))
                detalles = cursor.fetchone()
                if detalles:
                    gal = detalles.get("gallery", [])
                    # Forzar siempre array de strings
                    if isinstance(gal, list):
                        mapeada["gallery"] = [str(x) for x in gal if x]
                    elif isinstance(gal, str):
                        try:
                            import json
                            arr = json.loads(gal)
                            if isinstance(arr, list):
                                mapeada["gallery"] = [str(x) for x in arr if x]
                            else:
                                mapeada["gallery"] = [str(arr)]
                        except Exception:
                            mapeada["gallery"] = [gal]
                    else:
                        mapeada["gallery"] = []
                    specs = {k: v for k, v in detalles.items() if k not in ["id", "motorcycle_id", "gallery", "created_at", "updated_at"]}
                else:
                    mapeada["gallery"] = []
                    specs = {}

                # Diccionario de mapeo: campo SQL -> nombre en español
                spec_map = {
                    # motor y sistema eléctrico
                    "engine": "Tipo de motor",
                    "suspension": "Suspensión",
                    "displacement": "Cilindrada",
                    "power": "Potencia",
                    "max_torque": "Torque",
                    "ignition": "Encendido",
                    "start_type": "Arranque",
                    # dimensiones
                    "length": "Largo",
                    "width": "Ancho",
                    "height": "Alto",
                    "fuel_capacity": "Capacidad de combustible",
                    # otros
                    "brakes": "Frenos",
                    "tires": "Llantas",
                    "gearbox": "Caja",
                    "dashboard": "Tablero",
                    "alarm": "Alarma",
                    "usb": "USB",
                    "led_lights": "Luces LED",
                    "ohc": "OHC",
                    "digital_dashboard": "Tablero digital",
                }

                # Agrupar por categoría
                motor_electrico = {
                    spec_map["engine"]: m.get("engine"),
                    spec_map["suspension"]: specs.get("suspension"),
                    spec_map["displacement"]: m.get("displacement"),
                    spec_map["power"]: m.get("power"),
                    spec_map["max_torque"]: specs.get("max_torque"),
                    spec_map["ignition"]: specs.get("ignition"),
                    spec_map["start_type"]: specs.get("start_type"),
                }
                dimensiones = {
                    spec_map["length"]: specs.get("length"),
                    spec_map["width"]: specs.get("width"),
                    spec_map["height"]: specs.get("height"),
                    spec_map["fuel_capacity"]: specs.get("fuel_capacity"),
                }
                otros = {
                    spec_map["brakes"]: specs.get("brakes"),
                    spec_map["tires"]: specs.get("tires"),
                    spec_map["gearbox"]: specs.get("gearbox"),
                    spec_map["dashboard"]: specs.get("dashboard"),
                    spec_map["alarm"]: specs.get("alarm"),
                    spec_map["usb"]: specs.get("usb"),
                    spec_map["led_lights"]: specs.get("led_lights"),
                    spec_map["ohc"]: specs.get("ohc"),
                    spec_map["digital_dashboard"]: specs.get("digital_dashboard"),
                }
                mapeada["specifications"] = {
                    "motor y sistema eléctrico": motor_electrico,
                    "dimensiones": dimensiones,
                    "otros": otros
                }
                # Info de la marca
                cursor.execute("SELECT about FROM brand_info WHERE brand = %s", (m["brand"],))
                marca = cursor.fetchone()
                mapeada["brand_info"] = marca["about"] if marca else None
                motos_mapeadas.append(mapeada)
        return motos_mapeadas
    finally:
        conn.close()

@app.get("/motos/{moto_id}")
def get_moto(moto_id: int):
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute("SELECT * FROM motorcycles WHERE id = %s", (moto_id,))
            m = cursor.fetchone()
            if not m:
                raise HTTPException(status_code=404, detail="Moto no encontrada")
            cursor.execute("SELECT * FROM motorcycle_specs WHERE motorcycle_id = %s", (moto_id,))
            detalles = cursor.fetchone()
            cursor.execute("SELECT about FROM brand_info WHERE brand = %s", (m["brand"],))
            marca = cursor.fetchone()
            moto = dict(m)
            if detalles:
                gal = detalles.get("gallery", [])
                # Forzar siempre array de strings
                if isinstance(gal, list):
                    moto["gallery"] = [str(x) for x in gal if x]
                elif isinstance(gal, str):
                    try:
                        import json
                        arr = json.loads(gal)
                        if isinstance(arr, list):
                            moto["gallery"] = [str(x) for x in arr if x]
                        else:
                            moto["gallery"] = [str(arr)]
                    except Exception:
                        moto["gallery"] = [gal]
                else:
                    moto["gallery"] = []
                specs = {k: v for k, v in detalles.items() if k not in ["id", "motorcycle_id", "gallery", "created_at", "updated_at"]}
            else:
                moto["gallery"] = []
                specs = {}

            moto["specifications"] = {
                "motor y sistema eléctrico": {
                    "Tipo de motor": m.get("engine"),
                    "Suspensión": specs.get("suspension"),
                    "Cilindrada": m.get("displacement"),
                    "Potencia": m.get("power"),
                    "Torque": specs.get("max_torque"),
                    "Encendido": specs.get("ignition"),
                    "Arranque": specs.get("start_type"),
                },
                "dimensiones": {
                    "Largo": specs.get("length"),
                    "Ancho": specs.get("width"),
                    "Alto": specs.get("height"),
                    "Capacidad de combustible": specs.get("fuel_capacity"),
                },
                "otros": {
                    "Frenos": specs.get("brakes"),
                    "Llantas": specs.get("tires"),
                    "Caja": specs.get("gearbox"),
                    "Tablero": specs.get("dashboard"),
                    "Alarma": specs.get("alarm"),
                    "USB": specs.get("usb"),
                    "Luces LED": specs.get("led_lights"),
                    "OHC": specs.get("ohc"),
                    "Tablero digital": specs.get("digital_dashboard"),
                }
            }
            moto["brand_info"] = marca["about"] if marca else None
            return moto
    finally:
        conn.close()

@app.put("/motos/{moto_id}")
async def update_moto(moto_id: int, request: Request):
    data = await request.json()
    print(f"[DEBUG] Datos recibidos para actualizar moto ID {moto_id}:", data)
    
    specs = data.pop("specs", {})
    print(f"[DEBUG] Specs extraídas:", specs)
    
    # Solo los campos que existen en la tabla motorcycles
    engine = data.get("engine")
    displacement = data.get("displacement")
    power = data.get("power")
    price_soles = data.get("price_soles")
    style = data.get("style")
    transmission = data.get("transmission")
    image_url = data.get("image_url")
    color = data.get("color")
    description = data.get("description")
    is_active = data.get("is_active", True)
    gallery = data.get("gallery", [])
    
    print(f"[DEBUG] Campos principales: brand={data.get('brand')}, model={data.get('model')}, image_url={image_url}")
    
    # Normalizar gallery: asegurar que sea lista de strings y adaptarla a array de Postgres
    from psycopg2.extensions import AsIs
    if isinstance(gallery, str):
        import json
        try:
            gallery = json.loads(gallery)
        except Exception:
            gallery = [gallery]
    if not isinstance(gallery, list):
        gallery = [str(gallery)]
    gallery = [str(x) for x in gallery if x]
    
    # Si se está actualizando la imagen principal, agregarla automáticamente a la galería
    if image_url and image_url.strip():
        # Asegurar que la nueva imagen esté al principio de la galería
        if image_url not in gallery:
            gallery.insert(0, image_url)
        # Mantener solo las últimas 10 imágenes para evitar galerías muy largas
        gallery = gallery[:10]
    
    gallery_pg = gallery
    print("[DEBUG] Valor recibido en gallery (update):", gallery)

    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            # Primero obtener los datos actuales
            cursor.execute("SELECT * FROM motorcycles WHERE id = %s", (moto_id,))
            current_moto = cursor.fetchone()
            if not current_moto:
                raise HTTPException(status_code=404, detail="Motocicleta no encontrada")
            
            # Solo actualizar campos que tienen valores válidos (no vacíos)
            update_fields = []
            update_values = []
            
            fields_to_update = {
                "brand": data.get("brand"),
                "model": data.get("model"), 
                "year": data.get("year"),
                "engine": engine,
                "displacement": displacement,
                "power": power,
                "price_soles": price_soles,
                "style": style,
                "transmission": transmission,
                "image_url": image_url,
                "color": color,
                "description": description,
                "is_active": is_active
            }
            
            for field, value in fields_to_update.items():
                # Solo actualizar si el valor no está vacío/nulo o es boolean/numeric válido
                if field == "price_soles":
                    # Para price_soles, solo actualizar si es mayor que 0 o si específicamente se quiere poner en 0
                    if value is not None and (isinstance(value, (int, float)) and value > 0):
                        update_fields.append(f"{field}=%s")
                        update_values.append(value)
                elif (value is not None and 
                    (isinstance(value, bool) or 
                     isinstance(value, (int, float)) or 
                     (isinstance(value, str) and value.strip() != ""))):
                    update_fields.append(f"{field}=%s")
                    update_values.append(value)
            
            if update_fields:
                update_values.append(moto_id)
                sql = f"UPDATE motorcycles SET {', '.join(update_fields)} WHERE id=%s"
                print(f"[DEBUG] SQL de actualización: {sql}")
                print(f"[DEBUG] Valores: {update_values}")
                cursor.execute(sql, tuple(update_values))
            # Actualizar solo los campos enviados (parcial)
            # Primero verificar si existe el registro de specs
            cursor.execute("SELECT * FROM motorcycle_specs WHERE motorcycle_id = %s", (moto_id,))
            current_specs = cursor.fetchone()
            
            # Construir el update dinámico
            spec_update_fields = []
            spec_update_values = []
            
            # Lista de campos técnicos
            spec_keys = [
                "suspension", "telescopic_forks", "length", "width", "height", "max_speed", "max_torque", 
                "brakes", "fuel_capacity", "tires", "start_type", "tank", "dashboard", "ohc", 
                "digital_dashboard", "alarm", "ignition", "usb", "led_lights", "gearbox"
            ]
            
            for key in spec_keys:
                if key in specs and specs[key] and specs[key].strip():
                    spec_update_fields.append(f"{key}=%s")
                    spec_update_values.append(specs.get(key))
            
            # Siempre actualizar la galería si se proporciona
            if gallery_pg is not None:
                spec_update_fields.append("gallery=%s")
                spec_update_values.append(gallery_pg)
            
            if spec_update_fields:
                if current_specs:
                    # Actualizar registro existente
                    sql = f"UPDATE motorcycle_specs SET {', '.join(spec_update_fields)} WHERE motorcycle_id=%s"
                    spec_update_values.append(moto_id)
                    cursor.execute(sql, tuple(spec_update_values))
                else:
                    # Crear nuevo registro si no existe
                    fields = ["motorcycle_id"] + [field.split("=")[0] for field in spec_update_fields]
                    values = [moto_id] + spec_update_values[:-1] if gallery_pg is not None else [moto_id] + spec_update_values
                    placeholders = ["%s"] * len(values)
                    sql = f"INSERT INTO motorcycle_specs ({', '.join(fields)}) VALUES ({', '.join(placeholders)})"
                    cursor.execute(sql, tuple(values))
            # Si se provee info de la marca, actualizar brand_info
            if data.get("brand_info"):
                cursor.execute(
                    """
                    INSERT INTO brand_info (brand, about) VALUES (%s, %s)
                    ON CONFLICT (brand) DO UPDATE SET about = EXCLUDED.about
                    """,
                    (data.get("brand"), data.get("brand_info"))
                )
            conn.commit()
            return {"id": moto_id, **data, "specs": specs}
    finally:
        conn.close()

@app.delete("/motos/{moto_id}")
def delete_moto(moto_id: int):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute("DELETE FROM motorcycle_specs WHERE motorcycle_id = %s", (moto_id,))
            cursor.execute("DELETE FROM motorcycles WHERE id = %s", (moto_id,))
            conn.commit()
        return {"detail": "Moto eliminada"}
    finally:
        conn.close()

@app.get("/marcas")
def get_marcas():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute("SELECT brand, about FROM brand_info")
            marcas = cursor.fetchall()
        return marcas
    finally:
        conn.close()







