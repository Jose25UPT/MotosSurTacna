-- =============================================================
-- Catálogo ADVANCE (idempotente)
-- Fuente: datos proporcionados (inserciones originales con columnas estándar)
-- Requiere: schema/01_schema.sql y seed mínimo ejecutados
-- =============================================================

-- Notas:
--  * Se usa ON CONFLICT (brand, model) DO NOTHING para evitar duplicados.
--  * Luego se insertan specs sólo si no existen para ese motorcycle_id.
--  * image_url se deja como 'N/A' (puedes actualizar luego con ruta real).
--  * price_soles = 0 (pendiente de actualización comercial).
--  * gallery inicial vacía (ARRAY[]::text[]); en los datos venía 'N/A'.

-- Helper: función inline no necesaria; se aplican inserts directos.

-- =============== MODELOS ADVANCE ===============

-- ENDURO 200X
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','ENDURO 200X',2025,'Monocilíndrico OHC 4T','200 cc','16 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Rojo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','14 L','Eléctrico y pedal','Analógico','115 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='ENDURO 200X'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- TEKEN 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','TEKEN 250',2025,'Monocilíndrico OHC 4T','249 cc','20 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Rojo, Verde, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='TEKEN 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ADVENGER 200Z
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','ADVENGER 200Z',2025,'Monocilíndrico OHC 4T','198 cc','14.3 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','14 L','Eléctrico','Analógico','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='ADVENGER 200Z'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- NINDIA 200S
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','NINDIA 200S',2025,'Monocilíndrico OHC 4T','200 cc','17.20 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Verde, Naranja, Blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','14 L','Eléctrico y pedal','Digital','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='NINDIA 200S'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- JAGUAR 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','JAGUAR 200',2025,'Monocilíndrico OHC 4T','200 cc','15.7 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Rojo, Verde, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','14 L','Eléctrico y pedal','Digital','115 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='JAGUAR 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ZEUS 200Z
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','ZEUS 200Z',2025,'Monocilíndrico OHC 4T','200 cc','17.20 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','15 L','Eléctrico y pedal','Digital','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='ZEUS 200Z'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- NINDIA 250 R7
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','NINDIA 250 R7',2025,'Monocilíndrico OHC 4T','250 cc','18 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Marrón, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','135 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='NINDIA 250 R7'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- NINDIA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','NINDIA 250',2025,'Monocilíndrico OHC 4T','249.6 cc','15.4 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Verde, Azul, Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','130 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='NINDIA 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- BULTACO 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','BULTACO 250',2025,'Monocilíndrico OHC 4T','250 cc','16.3 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','115 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='BULTACO 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SCRAMPER 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','SCRAMPER 250',2025,'Monocilíndrico OHC 4T','250 cc','16 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Blanco, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='SCRAMPER 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SCRAMPLER 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','SCRAMPLER 200',2025,'Monocilíndrico OHC 4T','200 cc','15 HP / 7500 rpm',0,'Enduro','Cadena','N/A','Blanco, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Disco (trasero)','14 L','Eléctrico','Digital','120 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='SCRAMPLER 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- AD150 T-6
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','AD150 T-6',2025,'Monocilíndrico OHC 4T','150 cc','9.3 HP / 7500 rpm',0,'Scooter','Automática','N/A','Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','6 L','Eléctrico y pedal','Analógico','115 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='AD150 T-6'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SUPER MEGAN 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','SUPER MEGAN 125',2025,'Monocilíndrico OHC 4T','125 cc','9.3 HP / 7500 rpm',0,'Scooter','Semi automática','N/A','Azul, Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','6 L','Eléctrico y pedal','Analógico','85 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='SUPER MEGAN 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ASHLEY 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ADVANCE','ASHLEY 125',2025,'Monocilíndrico OHC 4T','125 cc','9.3 HP / 7500 rpm',0,'Scooter','Semi automática','N/A','Rojo, Negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
SELECT id,'Disco (delantero) / Tambor (trasero)','6 L','Eléctrico y pedal','Analógico','85 km/h', ARRAY[]::text[]
FROM motorcycles m WHERE m.brand='ADVANCE' AND m.model='ASHLEY 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- Ajuste de secuencias
SELECT setval('motorcycles_id_seq', (SELECT MAX(id) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT MAX(id) FROM motorcycle_specs));
