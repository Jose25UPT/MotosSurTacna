-- Schema baseline (sin CREATE DATABASE ni DROP destructivos)
-- Ejecutar solo una vez al inicializar un volumen nuevo

CREATE TABLE IF NOT EXISTS brand_info (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL UNIQUE,
    about TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS motorcycles (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    engine VARCHAR(100) DEFAULT 'N/A',
    displacement VARCHAR(50) DEFAULT 'N/A',
    power VARCHAR(50) DEFAULT 'N/A',
    price_soles NUMERIC(12,2) NOT NULL,
    style VARCHAR(50) DEFAULT 'N/A',
    transmission VARCHAR(50) DEFAULT 'N/A',
    image_url TEXT NOT NULL,
    color VARCHAR(100) DEFAULT 'N/A',
    description TEXT DEFAULT 'N/A',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS motorcycle_specs (
    id SERIAL PRIMARY KEY,
    motorcycle_id INTEGER REFERENCES motorcycles(id) ON DELETE CASCADE,
    suspension VARCHAR(100) DEFAULT 'N/A',
    telescopic_forks VARCHAR(100) DEFAULT 'N/A',
    length VARCHAR(50) DEFAULT 'N/A',
    width VARCHAR(50) DEFAULT 'N/A',
    height VARCHAR(50) DEFAULT 'N/A',
    max_speed VARCHAR(50) DEFAULT 'N/A',
    max_torque VARCHAR(50) DEFAULT 'N/A',
    brakes VARCHAR(100) DEFAULT 'N/A',
    fuel_capacity VARCHAR(50) DEFAULT 'N/A',
    tires VARCHAR(100) DEFAULT 'N/A',
    start_type VARCHAR(50) DEFAULT 'N/A',
    tank VARCHAR(50) DEFAULT 'N/A',
    dashboard VARCHAR(100) DEFAULT 'N/A',
    ohc VARCHAR(50) DEFAULT 'N/A',
    digital_dashboard VARCHAR(50) DEFAULT 'N/A',
    alarm VARCHAR(50) DEFAULT 'N/A',
    ignition VARCHAR(50) DEFAULT 'N/A',
    usb VARCHAR(50) DEFAULT 'N/A',
    led_lights VARCHAR(50) DEFAULT 'N/A',
	accessories TEXT DEFAULT 'N/A',
    gearbox VARCHAR(50) DEFAULT 'N/A',
    gallery TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Índices recomendados
CREATE INDEX IF NOT EXISTS idx_motorcycles_brand ON motorcycles(brand);
CREATE INDEX IF NOT EXISTS idx_motorcycles_style ON motorcycles(style);
CREATE INDEX IF NOT EXISTS idx_specs_motorcycle_id ON motorcycle_specs(motorcycle_id);
-- Índice único lógico para evitar duplicados por marca+modelo
CREATE UNIQUE INDEX IF NOT EXISTS ux_motorcycles_brand_model ON motorcycles(brand, model);


-- Ajusta las secuencias a los valores máximos actuales.
-- Útil después de cargas manuales o importaciones.

SELECT setval('brand_info_id_seq', COALESCE((SELECT MAX(id) FROM brand_info),1));
SELECT setval('motorcycles_id_seq', COALESCE((SELECT MAX(id) FROM motorcycles),1));
SELECT setval('motorcycle_specs_id_seq', COALESCE((SELECT MAX(id) FROM motorcycle_specs),1));

-- Verificación rápida (opcional)
-- SELECT 'brand_info', last_value FROM brand_info_id_seq;
-- SELECT 'motorcycles', last_value FROM motorcycles_id_seq;
-- SELECT 'motorcycle_specs', last_value FROM motorcycle_specs_id_seq;


-- =============================================================
-- Catálogo ULTRAVIP (idempotente)
-- Requiere: schema/01_schema.sql (ya crea índice único)
-- Ejecutar después de seeds mínimos.
-- =============================================================

-- CATÁLOGO ULTRAVIP AGOSTO 2025 - ORDEN CORRECTO CON NOMBRES REALES

-- 1. YIGO 125 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','YIGO 125 PRO',2025,'125cc, 4T','125cc','7.4 HP/8000 RPM',0,'Scooter','4 velocidades','/uploads/motos/yigo-125-pro.jpg','Varios colores disponibles','Tu compañera ideal para moverte con rapidez y seguridad',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','13.5 LT','Disco / Tambor','Analógico','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='YIGO 125 PRO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 2. TEKKEN 250 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','TEKKEN 250 PRO',2025,'250cc balanceado, 4 válvulas, Euro 4','250cc','19.5 HP/8300 RPM',0,'Deportiva','6 velocidades','/uploads/motos/tekken-250-pro.jpg','Varios colores disponibles','Toma el control, siente el poder en cada aceleración',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','12.5 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='TEKKEN 250 PRO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 3. DEFENDER 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','DEFENDER 250',2025,'250cc balanceado, 4T, Euro 4, OHC','250cc','18 HP/8200 RPM',0,'Deportiva','6 velocidades','/uploads/motos/defender-250.jpg','Varios colores disponibles','La potencia que desafía cualquier terreno',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','12 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='DEFENDER 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 4. A12 400
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','A12 400',2025,'400cc bicilíndrico, inyectada, 4T, Euro 4, OHC','400cc','33 HP/8300 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/a12-400.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas regulables / Monoshock','16.5 LT','Doble disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='A12 400'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 5. A12 300
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','A12 300',2025,'300cc, inyectada, 4T, Euro 4, OHC','300cc','27 HP/8600 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/a12-300.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas regulables / Monoshock','13 LT','Doble disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='A12 300'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 6. A12 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','A12 250',2025,'250cc, inyectada, 4T, Euro 4, OHC','250cc','23 HP/7400 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/a12-250.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas regulables / Monoshock','13 LT','Doble disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='A12 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 7. LEVIN 125 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','LEVIN 125 PRO',2025,'125cc, 4T','125cc','7.4 HP/8000 RPM',0,'Scooter','4 velocidades semiautomático','/uploads/motos/levin-125-pro.jpg','Varios colores disponibles','Máximo rendimiento con el mínimo esfuerzo',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','13.5 LT','Disco / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='LEVIN 125 PRO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 8. CYCLON 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','CYCLON 250',2025,'250cc balanceado, 4T, Euro 4, OHC','250cc','23 HP/7400 RPM',0,'Naked','6 velocidades','/uploads/motos/cyclon-250.jpg','Negro','Enciende el motor y crea tu propio camino',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','14 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='CYCLON 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 9. FORMULA 400
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','FORMULA 400',2025,'400cc bicilíndrica, inyectada, balanceado, 4T, Euro 4, OHC','400cc','33 HP/8300 RPM',0,'Naked','6 velocidades','/uploads/motos/formula-400.jpg','Varios colores disponibles','Menos consumo, más rendimiento, máxima emoción',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','16.5 LT','Disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='FORMULA 400'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 10. FORMULA 300
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','FORMULA 300',2025,'300cc, inyectada, balanceado, 4T, Euro 4, OHC','300cc','27 HP/8600 RPM',0,'Naked','6 velocidades','/uploads/motos/formula-300.jpg','Varios colores disponibles','Diseñadas para quienes exigen el máximo rendimiento',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','13 LT','Doble disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='FORMULA 300'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 11. FORMULA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','FORMULA 250',2025,'250cc, inyectada, balanceado, 4T, Euro 4, OHC','250cc','23 HP/7400 RPM',0,'Naked','6 velocidades','/uploads/motos/formula-250.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock','13 LT','Doble disco','Digital TFT','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='FORMULA 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 12. EURO 200 (AGOTADO)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','EURO 200',2025,'200cc balanceado, 4T, Euro 4','200cc','16 HP/8000 RPM',0,'Enduro','6 velocidades','/uploads/motos/euro-200.jpg','Varios colores disponibles','Arranca, acelera y disfruta sin distracciones',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','12 LT','Disco individual','Mixto','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='EURO 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 13. DRIFF 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','DRIFF 200',2025,'200cc balanceado, 4T','200cc','11 HP/8000 RPM',0,'Trail','6 velocidades','/uploads/motos/driff-200.jpg','Varios colores disponibles','Arranca el motor, deja el miedo atrás y conquista el camino',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','12 LT','Disco / Tambor','Digital','No', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='DRIFF 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 14. DRIFF 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','DRIFF 150',2025,'150cc, 4T','150cc','8.5 HP/7500 RPM',0,'Trail','5 velocidades','/uploads/motos/driff-150.jpg','Varios colores disponibles','La mejor opción para recorrer la ciudad sin límite',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','12 LT','Disco / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='DRIFF 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 15. DEYKER 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','DEYKER 250',2025,'250cc balanceado, 4T, Euro 4, OHC','250cc','18 HP/8500 RPM',0,'Street','6 velocidades','/uploads/motos/deyker-250.jpg','Varios colores disponibles','Conduce a tu manera, con estilo y precisión',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','15 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='DEYKER 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 16. LAZER 200 (AGOTADO)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','LAZER 200',2025,'200cc balanceado, 4T, Euro 4, OHC','200cc','16 HP/8000 RPM',0,'Street','6 velocidades','/uploads/motos/lazer-200.jpg','Varios colores disponibles','Pisando fuerte, acelerando con determinación',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','13.5 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='LAZER 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 17. GTR 200 (AGOTADO)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','GTR 200',2025,'200cc balanceado, 4T, Euro 4, OHC','200cc','16.5 HP/8300 RPM',0,'Racing','6 velocidades','/uploads/motos/gtr-200.jpg','Varios colores disponibles','Para los que viven con el acelerador a fondo',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas','15 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='GTR 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 18. GTR 250 (AGOTADO)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','GTR 250',2025,'250cc balanceado, 4T, Euro 4, OHC','250cc','18 HP/8500 RPM',0,'Racing','6 velocidades','/uploads/motos/gtr-250.jpg','Varios colores disponibles','La pista es tuya, exprime cada kilómetro',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas','15 LT','Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='GTR 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- Ajuste secuencias (opcional)
SELECT setval('motorcycles_id_seq', (SELECT MAX(id) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT MAX(id) FROM motorcycle_specs));



-- =============================================================
-- Catálogo DUCONDA (idempotente)
-- Origen: secciones DUCONDA del antiguo 02_seed.sql
-- Requiere índice único brand+model ya creado en schema.
-- =============================================================

-- Helper macro conceptual: cada modelo inserta motorcycles y luego specs si no existen.

-- Lista de modelos DUCONDA (año 2025) con campos mapeados:
-- engine <- columna original (motor)
-- displacement <- cilindrada (ej: '150 cc') se normaliza manteniendo mayúsculas original
-- power <- potencia (ej: '8.3 HP / 7500 r/min')
-- transmission <- transmision (CVT, OCH, etc.)
-- style: se deja 'N/A' porque el seed anterior no distinguía (puedes ajustar manualmente luego)
-- image_url: placeholder genérico por ahora (personaliza luego)
-- description: 'N/A' para completar más tarde
-- price_soles: 0 por ausencia de precios

-- NEWDUX 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','NEWDUX 150',2025,'4 tiempos CVT','150 cc','8.3 HP / 7500 r/min',0,'N/A','CVT','/uploads/motos/duconda-newdux-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
-- Insert base specs si no existen
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='NEWDUX 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
-- Enriquecimiento (idempotente usando UPDATE)
UPDATE motorcycle_specs s SET
	suspension='Barras telescópicas / Doble amortiguador',
	telescopic_forks='Barras telescópicas',
	length='190 cm',
	width='68.5 cm',
	height='108.5 cm',
	max_speed='100 km/h',
	gearbox='CVT'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='NEWDUX 150';

-- DUVI 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','DUVI 150',2025,'4 tiempos CVT','150 cc','26 HP / 8500 r/min',0,'N/A','CVT','/uploads/motos/duconda-duvi-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='DUVI 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='203 cm',
	width='85.6 cm',
	height='112.4 cm',
	max_speed='100 km/h',
	gearbox='CVT'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='DUVI 150';

-- SDUX 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','SDUX 200',2025,'4 tiempos OCH','200 cc','17 HP / 8000 r/min',0,'N/A','N/A','/uploads/motos/duconda-sdux-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='SDUX 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='185 cm',
	width='85.6 cm',
	height='112.4 cm',
	max_speed='130 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='SDUX 200';

-- FORTE 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','FORTE 150',2025,'4 tiempos CVT','150 cc','8.4 HP / 7500 r/min',0,'N/A','CVT','/uploads/motos/duconda-forte-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='FORTE 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras telescópicas / Doble amortiguador',
	telescopic_forks='Barras telescópicas',
	max_torque='105 kg / 150 kg',
	max_speed='100 km/h',
	gearbox='CVT'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='FORTE 150';

-- HORSE/EMPIRE
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','HORSE/EMPIRE',2025,'4 tiempos OCH','150 cc','11 HP / 8000 r/min',0,'N/A','N/A','/uploads/motos/duconda-horse-empire-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='HORSE/EMPIRE'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='207 cm',
	width='78 cm',
	height='108.5 cm',
	max_speed='100 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='HORSE/EMPIRE';

-- DU-R200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','DU-R200',2025,'4 tiempos OCH / Balanceador','200 cc','17 HP / 8000 r/min',0,'N/A','N/A','/uploads/motos/duconda-du-r200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='DU-R200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='203 cm',
	width='85 cm',
	height='112.4 cm',
	max_speed='130 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='DU-R200';

-- DU-300
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','DU-300',2025,'4 tiempos OCH / Balanceador','300 cc','21 HP / 8500 r/min',0,'N/A','N/A','/uploads/motos/duconda-du-300.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='DU-300'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='203 cm',
	width='85 cm',
	height='112.4 cm',
	max_speed='150 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='DU-300';

-- TEKK 300 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','TEKK 300 PRO',2025,'4 tiempos OCH / Balanceador','300 cc','27.3 HP / 8500 r/min',0,'N/A','N/A','/uploads/motos/duconda-tekk-300-pro.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='TEKK 300 PRO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='182 cm',
	width='49 cm',
	height='88 cm',
	max_speed='130 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='TEKK 300 PRO';

-- DUCO 250 DT
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','DUCO 250 DT',2025,'4 tiempos OCH / Balanceador','250 cc','16 HP / 7500 r/min',0,'N/A','N/A','/uploads/motos/duconda-duco-250-dt.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='DUCO 250 DT'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='200 cm',
	width='77 cm',
	height='117 cm',
	max_speed='125 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='DUCO 250 DT';

-- R300
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','R300',2025,'4 tiempos OCH / Balanceador','300 cc','26 HP / 8500 r/min',0,'N/A','N/A','/uploads/motos/duconda-r300.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='R300'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras invertidas / Monoshock',
	telescopic_forks='Barras invertidas',
	length='203 cm',
	width='85.6 cm',
	height='112.4 cm',
	max_speed='150 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='R300';

-- DUCO 200DT
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('DUCONDA','DUCO 200DT',2025,'4 tiempos OCH / Balanceador','200 cc','17 HP / 8500 r/min',0,'N/A','N/A','/uploads/motos/duconda-duco-200dt.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m
WHERE m.brand='DUCONDA' AND m.model='DUCO 200DT'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET
	suspension='Barras telescópicas / Monoshock',
	telescopic_forks='Barras telescópicas',
	length='213 cm',
	width='82 cm',
	height='120 cm',
	max_speed='120 km/h'
FROM motorcycles m
WHERE s.motorcycle_id=m.id AND m.brand='DUCONDA' AND m.model='DUCO 200DT';

-- Ajuste de secuencias opcional
SELECT setval('motorcycles_id_seq', (SELECT MAX(id) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT MAX(id) FROM motorcycle_specs));



-- =============================================================
-- Catálogo JCH (idempotente completo)
-- Fuente: bloque legacy JCH del antiguo script monolítico.
-- Patrón: INSERT motos ON CONFLICT + INSERT base specs (si faltan) + UPDATE enriquecedor.
-- =============================================================

-- Helper para consistencia de estilo: se mantiene 'N/A' (puedes reclasificar después: Scooter, Trabajo, Sport, Dual, etc.)
-- image_url: placeholders; reemplaza con rutas reales cuando existan.

-- KALLPA 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','KALLPA 150',2025,'OHC','149.6 CC','7.9 hp / 7000 rpm',0,'N/A','N/A','/uploads/motos/jch-kallpa-150.jpg','azul, negro, rojo, blanco, dorado','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='KALLPA 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Telescópica / Doble Amortiguador', tires='130/60-13 // 130/60-13'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='KALLPA 150';

-- T-28 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','T-28 150',2025,'OHC','149.6 CC','8.98 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-t-28-150.jpg','negro, rojo, azul, blanco, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='T-28 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Telescópica / Doble Amortiguador', tires='120/70-12 // 120/70-12'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='T-28 150';

-- URBAN T-29 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','URBAN T-29 150',2025,'OHC','149.6 CC','8.71 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-urban-t-29-150.jpg','azul, negro, rojo, blanco, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='URBAN T-29 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Telescópica / Doble Amortiguador', tires='120/70-12 // 120/70-12'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='URBAN T-29 150';

-- STYLE 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','STYLE 150',2025,'OHC','149.6 CC','8.71 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-style-150.jpg','morado, negro, blanco, rojo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='STYLE 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble Amortiguador', tires='3.50-10 // 3.50-10'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='STYLE 150';

-- VOLT 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','VOLT 150',2025,'OHC','149.6 CC','9.65 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-volt-150.jpg','rojo, negro, blanco, morado','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='VOLT 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble Amortiguador', tires='3.50-10 // 3.50-10'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='VOLT 150';

-- ONE 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','ONE 125',2025,'OHC','119.7 CC','8.7 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-one-125.jpg','azul, rojo, verde, negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='ONE 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='2.50-17 // 2.75-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='ONE 125';

-- EAGLE 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','EAGLE 125',2025,'OHC','106.7 CC','7.51 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-eagle-125.jpg','rojo, negro, blanco, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='EAGLE 125' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='150/80-13 // 115/80-13'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='EAGLE 125';

-- ENERGY 110
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','ENERGY 110',2025,'OHC','106.7 CC','6.71 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-energy-110.jpg','rojo, negro, azul','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='ENERGY 110' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='110/90-13 // 110/90-13'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='ENERGY 110';

-- FALKON 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','FALKON 150',2025,'OHC','149 CC','12.3 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-falkon-150.jpg','azul, rojo, negro, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='FALKON 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='2.75-18 // 3.25-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='FALKON 150';

-- TARKI 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TARKI 150',2025,'OHC','149 CC','12.3 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-tarki-150.jpg','azul, rojo, negro, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TARKI 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Tambor / Tambor', suspension='Telescópica / Doble amortiguador', tires='2.75-18 // 3.00-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TARKI 150';

-- WORKMAN 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','WORKMAN 150',2025,'OHV','149 CC','12.3 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-workman-150.jpg','verde, negro, azul, rojo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='WORKMAN 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='110/90-17 // 130/80-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='WORKMAN 150';

-- TRAVEL 250 (OFF-ROAD)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TRAVEL 250 (OFF-ROAD)',2025,'OHC','223 CC','17.4 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-travel-250-offroad.jpg','rojo, negro, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TRAVEL 250 (OFF-ROAD)' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='4.60-17 // 5.10-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TRAVEL 250 (OFF-ROAD)';

-- TRAVEL 250 (DOBLE PROPÓSITO)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TRAVEL 250 (DOBLE PROPÓSITO)',2025,'OHC','223 CC','17.4 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-travel-250-doble.jpg','negro, verde, marrón','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TRAVEL 250 (DOBLE PROPÓSITO)' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='110/90-17 // 130/80-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TRAVEL 250 (DOBLE PROPÓSITO)';

-- ARIZONA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','ARIZONA 250',2025,'OHC','223 CC','17.7 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-arizona-250.jpg','negro, rojo, naranja, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='ARIZONA 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Barras invertidas / Monoshock', tires='3.50-17 // 4.60-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='ARIZONA 250';

-- CROSSMAX 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','CROSSMAX 250',2025,'OHC','229.6 CC','14 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-crossmax-250.jpg','naranja, negro, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='CROSSMAX 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Barras invertidas / Monoshock', tires='3.50-17 // 4.60-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='CROSSMAX 250';

-- MRX 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','MRX 200',2025,'OHV','196.98 CC','13 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-mrx-200.jpg','negro, rojo, azul','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='MRX 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='90/100-19 // 4.60-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='MRX 200';

-- TRACKER 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TRACKER 200',2025,'OHV','196.98 CC','13 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-tracker-200.jpg','naranja, negro, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TRACKER 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Barras invertidas / Monoshock', tires='110/90-17 // 130/80-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TRACKER 200';

-- TITAN 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TITAN 200',2025,'OHV','197 CC','13.67 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-titan-200.jpg','azul, rojo, negro, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TITAN 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='100/90-19 // 4.60-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TITAN 200';

-- TORNADO 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','TORNADO 200',2025,'OHV','196.98 CC','13 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-tornado-200.jpg','rojo, negro, blanco, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='TORNADO 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='80/100-18 // 120/80-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='TORNADO 200';

-- MONTANA 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','MONTANA 200',2025,'OHV','197 CC','14.08 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-montana-200.jpg','rojo, negro, azul, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='MONTANA 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='3.50-17 // 4.60-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='MONTANA 200';

-- MRX 200 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','MRX 200 PRO',2025,'OHV','196.98 CC','13 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-mrx-200-pro.jpg','rojo, negro, azul, verde','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='MRX 200 PRO' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Monoshock', tires='90/90-19 // 110/100-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='MRX 200 PRO';

-- GS 250 4V
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','GS 250 4V',2025,'OHC','249.4 CC','24.13 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-gs-250-4v.jpg','azul, gris, negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='GS 250 4V' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='110/90-17 // 130/80-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='GS 250 4V';

-- INDIAN 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','INDIAN 250',2025,'OHV','229.5 CC','14.08 hp / 7000 rpm',0,'N/A','N/A','/uploads/motos/jch-indian-250.jpg','rojo, negro, blanco, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='INDIAN 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='110/90-16 // 130/90-15'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='INDIAN 250';

-- SPORT 300
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','SPORT 300',2025,'OHC','271.3 CC','21.4 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-sport-300.jpg','negro, rojo, verde, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='SPORT 300' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco doble / Disco', suspension='Barras invertidas / Monoshock', tires='110/70-17 // 150/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='SPORT 300';

-- RACING 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','RACING 250',2025,'OHC','249.6 CC','15.42 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-racing-250.jpg','negro, naranja, azul, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='RACING 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco doble / Disco', suspension='Barras invertidas / Monoshock', tires='110/70-17 // 150/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='RACING 250';

-- R6 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','R6 250',2025,'OHC','249.9 CC','18.77 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-r6-250.jpg','negro, azul, naranja','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='R6 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Telescópica / Monoshock', tires='110/70-17 // 150/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='R6 250';

-- RZ88 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','RZ88 250',2025,'OHC','249.9 CC','18.77 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-rz88-250.jpg','blanco, azul, negro','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='RZ88 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco doble / Disco', suspension='Telescópica / Monoshock', tires='110/70-17 // 150/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='RZ88 250';

-- SPORT 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','SPORT 200',2025,'OHC','197 CC','16 hp / 8000 rpm',0,'N/A','N/A','/uploads/motos/jch-sport-200.jpg','naranja, negro, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='SPORT 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='110/70-17 // 130/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='SPORT 200';

-- KP MINI 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','KP MINI 150',2025,'OHC','149 CC','12.7 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-kp-mini-150.jpg','rojo, negro, azul, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='KP MINI 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='120/70-12 // 130/70-12'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='KP MINI 150';

-- RAPID 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','RAPID 150',2025,'OHV','149.6 CC','12.34 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-rapid-150.jpg','negro, amarillo, azul, rojo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='RAPID 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='2.75-18 // 3.00-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='RAPID 150';

-- MAX 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','MAX 150',2025,'OHV','149 CC','11.8 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-max-150.jpg','negro, rojo, azul, amarillo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='MAX 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='110/70-17 // 130/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='MAX 150';

-- WORK 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','WORK 150',2025,'OHV','149 CC','12.3 hp / 8500 rpm',0,'N/A','N/A','/uploads/motos/jch-work-150.jpg','negro, azul, rojo, blanco','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='WORK 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Tambor', suspension='Telescópica / Doble amortiguador', tires='2.75-18 // 3.00-18'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='WORK 150';

-- MT 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('JCH','MT 200',2025,'OHC','196.8 CC','13.6 hp / 7500 rpm',0,'N/A','N/A','/uploads/motos/jch-mt-200.jpg','azul, negro, rojo','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id)
SELECT id FROM motorcycles m WHERE m.brand='JCH' AND m.model='MT 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco / Disco', suspension='Barras invertidas / Monoshock', tires='100/80-17 // 130/70-17'
FROM motorcycles m WHERE m.id=s.motorcycle_id AND m.brand='JCH' AND m.model='MT 200';

-- Ajuste de secuencias (opcional; maintenance script ya corrige)
SELECT setval('motorcycles_id_seq', (SELECT MAX(id) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT MAX(id) FROM motorcycle_specs));






-- Convenciones:
--  * style: tomado literal de los datos fuente (Ciudad, Scooter, Utilitarias, Premium, Todoterreno)
--  * transmission -> gearbox en specs
--  * brakes preserva formato original (Disco/Tambor, Disco/Disco, Doble Disco/Disco)
--  * image_url: path estándar basado en slug del modelo
--  * Inserción idempotente: ON CONFLICT DO NOTHING + inserción condicional de specs + UPDATE de enriquecimiento (para frenos si ya existía fila previa sin datos)

-- Helper: función mental de slug (solo documentación)
--   Mayúsculas -> minúsculas, espacios -> '-', puntos '4.0' -> '-4-0', caracteres especiales retirados.

-- =============================================================
-- MODELOS REZZIO
-- =============================================================

-- Athorm 200 6G
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Athorm 200 6G',2025,'N/A','200 CC','18 HP/8000 RPM',0,'Ciudad','6 velocidades','/uploads/motos/rezzio-athorm-200-6g.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Athorm 200 6G'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Athorm 200 6G') AND (s.brakes IS NULL OR s.brakes='');

-- Velox 200 6G
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Velox 200 6G',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Ciudad','6 velocidades','/uploads/motos/rezzio-velox-200-6g.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Velox 200 6G'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Velox 200 6G') AND (s.brakes IS NULL OR s.brakes='');

-- Maxos 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Maxos 150',2025,'N/A','150 CC','12.7 HP/9000 RPM',0,'Ciudad','4 velocidades','/uploads/motos/rezzio-maxos-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'4 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Maxos 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Maxos 150') AND (s.brakes IS NULL OR s.brakes='');

-- Confort 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Confort 150',2025,'N/A','150 CC','12 HP/7000 RPM',0,'Scooter','Automático','/uploads/motos/rezzio-confort-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'Automático','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Confort 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Confort 150') AND (s.brakes IS NULL OR s.brakes='');

-- Pluss 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Pluss 150',2025,'N/A','150 CC','12 HP/7000 RPM',0,'Scooter','Automático','/uploads/motos/rezzio-pluss-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'Automático','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Pluss 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Pluss 150') AND (s.brakes IS NULL OR s.brakes='');

-- Lite 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Lite 150',2025,'N/A','150 CC','12 HP/7000 RPM',0,'Scooter','Automático','/uploads/motos/rezzio-lite-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'Automático','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Lite 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Lite 150') AND (s.brakes IS NULL OR s.brakes='');

-- Rocket 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Rocket 125',2025,'N/A','125 CC','8.3 HP/7000 RPM',0,'Scooter','4 velocidades','/uploads/motos/rezzio-rocket-125.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'4 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Rocket 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Rocket 125') AND (s.brakes IS NULL OR s.brakes='');

-- Spark 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Spark 125',2025,'N/A','125 CC','8.3 HP/7000 RPM',0,'Scooter','4 velocidades','/uploads/motos/rezzio-spark-125.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'4 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Spark 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Spark 125') AND (s.brakes IS NULL OR s.brakes='');

-- Waze 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Waze 125',2025,'N/A','150 CC','12 HP/7000 RPM',0,'Scooter','Automático','/uploads/motos/rezzio-waze-125.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'Automático','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Waze 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Waze 125') AND (s.brakes IS NULL OR s.brakes='');

-- Power 200 6G
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Power 200 6G',2025,'N/A','200 CC','16 HP/7000 RPM',0,'Utilitarias','6 velocidades','/uploads/motos/rezzio-power-200-6g.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Power 200 6G'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Power 200 6G') AND (s.brakes IS NULL OR s.brakes='');

-- Power 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Power 200',2025,'N/A','200 CC','16 HP/7000 RPM',0,'Utilitarias','6 velocidades','/uploads/motos/rezzio-power-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Power 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Power 200') AND (s.brakes IS NULL OR s.brakes='');

-- Power 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Power 150',2025,'N/A','150 CC','12 HP/7000 RPM',0,'Utilitarias','4 velocidades','/uploads/motos/rezzio-power-150.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'4 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Power 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Power 150') AND (s.brakes IS NULL OR s.brakes='');

-- Kratos Pro 4.0
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Kratos Pro 4.0',2025,'N/A','367 CC','23 HP/8000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-kratos-pro-4-0.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Doble Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Kratos Pro 4.0'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Doble Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Kratos Pro 4.0') AND (s.brakes IS NULL OR s.brakes='');

-- Predator Pro 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Predator Pro 250',2025,'N/A','250 CC','21 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-predator-pro-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Predator Pro 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Predator Pro 250') AND (s.brakes IS NULL OR s.brakes='');

-- Z-Max 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Z-Max 250',2025,'N/A','250 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-z-max-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Z-Max 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Z-Max 250') AND (s.brakes IS NULL OR s.brakes='');

-- Honor 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Honor 250',2025,'N/A','250 CC','16 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-honor-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Honor 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Honor 250') AND (s.brakes IS NULL OR s.brakes='');

-- Kratos 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Kratos 250',2025,'N/A','250 CC','18 HP/7500 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-kratos-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Kratos 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Kratos 250') AND (s.brakes IS NULL OR s.brakes='');

-- Predator 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Predator 250',2025,'N/A','250 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-predator-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Predator 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Predator 250') AND (s.brakes IS NULL OR s.brakes='');

-- Voltrex 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Voltrex 250',2025,'N/A','250 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-voltrex-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Voltrex 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Voltrex 250') AND (s.brakes IS NULL OR s.brakes='');

-- XPlotion 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','XPlotion 250',2025,'N/A','250 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-xplotion-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='XPlotion 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='XPlotion 250') AND (s.brakes IS NULL OR s.brakes='');

-- Aventus 2.0
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Aventus 2.0',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-aventus-2-0.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Aventus 2.0'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Aventus 2.0') AND (s.brakes IS NULL OR s.brakes='');

-- Rextor 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Rextor 200',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-rextor-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Rextor 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Rextor 200') AND (s.brakes IS NULL OR s.brakes='');

-- Lithium 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Lithium 200',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Premium','6 velocidades','/uploads/motos/rezzio-lithium-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Lithium 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Lithium 200') AND (s.brakes IS NULL OR s.brakes='');

-- KTR 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','KTR 250',2025,'N/A','250 CC','18 HP/8000 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-ktr-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='KTR 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='KTR 250') AND (s.brakes IS NULL OR s.brakes='');

-- ZRF 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','ZRF 250',2025,'N/A','250 CC','18 HP/7500 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-zrf-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='ZRF 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='ZRF 250') AND (s.brakes IS NULL OR s.brakes='');

-- Primex 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','Primex 250',2025,'N/A','250 CC','18 HP/7000 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-primex-250.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='Primex 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='Primex 250') AND (s.brakes IS NULL OR s.brakes='');

-- FMX 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','FMX 200',2025,'N/A','200 CC','18 HP/8000 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-fmx-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Tambor', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='FMX 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='FMX 200') AND (s.brakes IS NULL OR s.brakes='');

-- X-Pro 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','X-Pro 200',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-x-pro-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='X-Pro 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='X-Pro 200') AND (s.brakes IS NULL OR s.brakes='');

-- XTrail 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('REZZIO','XTrail 200',2025,'N/A','200 CC','18 HP/7000 RPM',0,'Todoterreno','6 velocidades','/uploads/motos/rezzio-xtrail-200.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, gearbox, brakes, gallery)
SELECT id,'6 velocidades','Disco/Disco', ARRAY[]::text[] FROM motorcycles m WHERE m.brand='REZZIO' AND m.model='XTrail 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='REZZIO' AND model='XTrail 200') AND (s.brakes IS NULL OR s.brakes='');


-- =============================================================
-- Ajuste de secuencias (seguridad, idempotente)
-- =============================================================
SELECT setval('motorcycles_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycle_specs));



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


-- =============================================================
-- Catálogo SONLINK (idempotente)
-- Fuente: extracto legacy tienda_motos.sql (sección SONLINK)
-- =============================================================
-- Convenciones:
-- * Se omite id (lo asigna la secuencia) y se usa ON CONFLICT (brand, model) DO NOTHING
-- * gearbox se deriva de transmission original (tomando la primera opción antes de guiones múltiples si aplica)
-- * Para combinaciones tipo '5/6 velocidades' se conserva texto completo en gearbox
-- * max_torque mantiene el formato exacto de origen
-- * gallery inicializado vacío (ARRAY[]::text[])
-- * UPDATE asegura brakes no nulo si ya existía fila specs
-- =============================================================

-- SL150/200-F1
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150/200-F1',2025,'TGF(OHV)','150/200 CC','13/8500 - 13.6/8000',0,'Pistero','5/6 velocidades','/uploads/motos/sonlink-sl150-200-f1.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Barras invertidas / Monoshock','11.5/7500 - 14.2/6000','Disco/Disco','14.5L','90/90-17 120/80-17','5/6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150/200-F1' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150/200-F1') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-GF/GFA
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-GF/GFA',2025,'TGF(OHV) / CBF(OHC)','200 CC','15/8000',0,'Pistero','5/6 velocidades - 5 velocidades','/uploads/motos/sonlink-sl200-gf-gfa.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Barras invertidas/Monoshock','15/5000','Disco/Disco','15L','100/70-17 150/70-17','5/6 velocidades - 5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-GF/GFA' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-GF/GFA') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-F7
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-F7',2025,'TGF(OHV)','200 CC','16/8000',0,'Pistero','5/6 velocidades','/uploads/motos/sonlink-sl200-f7.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Barras invertidas/Monoshock','15/5000','Disco/Disco','21L','100/80-17 130/70-17','5/6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-F7' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-F7') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-F8
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-F8',2025,'TGF(OHV)','200 CC','15/8000',0,'Pistero','5/6 velocidades','/uploads/motos/sonlink-sl200-f8.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Barras invertidas/Monoshock','15/5000','Disco/Disco','15L','90/90-17 120/80-17','5/6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-F8' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-F8') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-F8A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-F8A',2025,'TGF(OHV)','200 CC','15/8000',0,'Pistero','5/6 velocidades','/uploads/motos/sonlink-sl200-f8a.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Barras invertidas/Monoshock','15/5000','Disco/Disco','15L','90/90-17 120/80-17','5/6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-F8A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-F8A') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-F9/F9A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-F9/F9A',2025,'TGF(OHV) / CBF(OHC)','200 CC','15/8000',0,'Pistero','5/6 velocidades - 5 velocidades','/uploads/motos/sonlink-sl200-f9-f9a.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Monoshock','15/8000','Disco/Disco','14L','100/70-17 130/70-17','5/6 velocidades - 5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-F9/F9A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-F9/F9A') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-K11
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-K11',2025,'N/A','200 CC','13.5/8500',0,'Paseo','5 velocidades','/uploads/motos/sonlink-sl200-k11.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','11.8/6500','Tambor/Tambor','15.5L','3.25-18 3.25-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-K11' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Tambor/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-K11') AND (s.brakes IS NULL OR s.brakes='');

-- SL150-KG
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150-KG',2025,'N/A','150 CC','6.2/7500',0,'Paseo','CVT','/uploads/motos/sonlink-sl150-kg.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','8.5/6500','Disco/Tambor','5.5L','Disco/Tambor','CVT',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150-KG' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150-KG') AND (s.brakes IS NULL OR s.brakes='');

-- SL105
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL105',2025,'N/A','105 CC','7.5/8500',0,'Paseo','4 velocidades','/uploads/motos/sonlink-sl105.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','6.5/6500','Disco/Disco','9.1L','2.50-17 2.75-17','4 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL105' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL105') AND (s.brakes IS NULL OR s.brakes='');

-- SL125T-2A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL125T-2A',2025,'N/A','125 CC','6.2/7500',0,'Paseo','CVT','/uploads/motos/sonlink-sl125t-2a.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','8.5/6500','Disco/Tambor','5.5L','Disco/Tambor','CVT',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL125T-2A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL125T-2A') AND (s.brakes IS NULL OR s.brakes='');

-- SL150T-5
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150T-5',2025,'N/A','150 CC','8.5/6500',0,'Paseo','CVT','/uploads/motos/sonlink-sl150t-5.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','8.5/6500','Disco/Tambor','5.5L','120/70-12 120/70-12','CVT',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150T-5' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150T-5') AND (s.brakes IS NULL OR s.brakes='');

-- SL150T-6
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150T-6',2025,'N/A','150 CC','8.5/6500',0,'Paseo','CVT','/uploads/motos/sonlink-sl150t-6.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','8.5/6500','Disco/Tambor','5.5L','120/70-12 120/70-12','CVT',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150T-6' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150T-6') AND (s.brakes IS NULL OR s.brakes='');

-- SL200G-3
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200G-3',2025,'N/A','200 CC','15/8000',0,'Todo Terreno','5 velocidades','/uploads/motos/sonlink-sl200g-3.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Monoshock','15/8000','Disco/Disco','16L','2.50-17 4.60-17','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200G-3' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200G-3') AND (s.brakes IS NULL OR s.brakes='');

-- SL200G-LI
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200G-LI',2025,'N/A','200 CC','15/8000',0,'Todo Terreno','5 velocidades','/uploads/motos/sonlink-sl200g-li.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Monoshock','15/8000','Disco/Disco','15L','2.50-17 4.60-17','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200G-LI' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Disco' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200G-LI') AND (s.brakes IS NULL OR s.brakes='');

-- SL200-3F
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL200-3F',2025,'N/A','200 CC','15/8000',0,'Ciudad','5 velocidades','/uploads/motos/sonlink-sl200-3f.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','14.5/5000','Disco/Tambor','14L','2.75-18 90/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL200-3F' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL200-3F') AND (s.brakes IS NULL OR s.brakes='');

-- SL150-HB
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150-HB',2025,'N/A','150 CC','12.5/8500',0,'Ciudad','5 velocidades','/uploads/motos/sonlink-sl150-hb.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','11.5/7000','Disco/Tambor','16L','2.75-18 3.00-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150-HB' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150-HB') AND (s.brakes IS NULL OR s.brakes='');

-- SL150-17A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150-17A',2025,'N/A','150 CC','12/8500',0,'Ciudad','5 velocidades','/uploads/motos/sonlink-sl150-17a.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','11/7000','Disco/Tambor','16.5L','2.75-18 3.00-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150-17A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Disco/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150-17A') AND (s.brakes IS NULL OR s.brakes='');

-- SL150/200-A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('SONLINK','SL150/200-A',2025,'N/A','150/200 CC','12.6/8500',0,'Moto Taxi','5 velocidades','/uploads/motos/sonlink-sl150-200-a.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'Telescópica/Brazos Oscilantes','15/8000','Tambor/Tambor','14L','2.75-18 3.25-17','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='SONLINK' AND m.model='SL150/200-A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs s SET brakes='Tambor/Tambor' WHERE s.motorcycle_id=(SELECT id FROM motorcycles WHERE brand='SONLINK' AND model='SL150/200-A') AND (s.brakes IS NULL OR s.brakes='');

-- =============================================================
-- Ajuste de secuencias
-- =============================================================
SELECT setval('motorcycles_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycle_specs));




-- =============================================================
-- Catálogo WANXIN (idempotente)
-- Fuente: sección WANXIN en legacy tienda_motos.sql
-- =============================================================
-- Convenciones:
-- * Se preservan valores textuales originales (power, max_torque, tires, etc.)
-- * gearbox deriva de 'transmission' literal (ej: '6 velocidades', '5 velocidades', '4 velocidades')
-- * Cuando brakes es 'N/A' se deja nulo inicialmente y se podrá enriquecer después
-- * gallery vacío para futura carga de imágenes
-- =============================================================

-- PARLOUR 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','PARLOUR 200',2025,'4T-OHC','200 CC','18.5/8500',0,'Sport','6 velocidades','/uploads/motos/wanxin-parlour-200.jpg','Azul','Modelo deportivo con motor 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','18.2/7500','Disco/Disco','16L','120/70-17 180/55-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='PARLOUR 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='PARLOUR 200') AND (brakes IS NULL OR brakes='');

-- K01200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','K01200',2025,'4T-OHC','200 CC','18.5/8500',0,'Adventure','6 velocidades','/uploads/motos/wanxin-k01200.jpg','Azul','Modelo Adventure/Enduro con motor 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','18.2/7500','Disco/Disco','16L','90/90-21 120/80-18','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='K01200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='K01200') AND (brakes IS NULL OR brakes='');

-- MS200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','MS200',2025,'4T-OHC','200 CC','18.5/8500',0,'Sport','6 velocidades','/uploads/motos/wanxin-ms200.jpg','Negro/Verde','Modelo deportivo con motor 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','18.2/7500','Disco/Disco','16L','110/70-17 150/60-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='MS200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='MS200') AND (brakes IS NULL OR brakes='');

-- ROADBLOCK 250 II
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','ROADBLOCK 250 II',2025,'4T-OHC','250 CC','20/8000',0,'Sport','6 velocidades','/uploads/motos/wanxin-roadblock-250-ii.jpg','Azul','Modelo pistera 250cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','22/6500','Disco/Disco','15L','120/70-17 180/55-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='ROADBLOCK 250 II' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='ROADBLOCK 250 II') AND (brakes IS NULL OR brakes='');

-- TOK-125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','TOK-125',2025,'4T-OHC','125 CC','9.5/8000',0,'Sport','6 velocidades','/uploads/motos/wanxin-tok-125.jpg','Rojo','Modelo pistera 125cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','10.2/6500','Disco/Disco','12L','100/80-17 130/70-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='TOK-125' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='TOK-125') AND (brakes IS NULL OR brakes='');

-- ENERGY 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','ENERGY 200',2025,'4T-OHC','200 CC','16/8500',0,'Sport','6 velocidades','/uploads/motos/wanxin-energy-200.jpg','Amarillo','Modelo pistera 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.5/7000','Disco/Disco','14L','110/70-17 150/60-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='ENERGY 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='ENERGY 200') AND (brakes IS NULL OR brakes='');

-- PS200N
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','PS200N',2025,'4T-OHC','200 CC','16/8500',0,'Sport','6 velocidades','/uploads/motos/wanxin-ps200n.jpg','Negro/Naranja','Modelo pistera 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.5/7000','Disco/Disco','14L','110/70-17 150/60-17','6 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='PS200N' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='PS200N') AND (brakes IS NULL OR brakes='');

-- AMARU 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','AMARU 200',2025,'4T-OHC','200 CC','16/8000',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-amaru-200.jpg','Negro/Verde','Modelo todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','17/6500','Disco/Disco','12L','3.00-21 4.60-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='AMARU 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='AMARU 200') AND (brakes IS NULL OR brakes='');

-- WX150G-P2
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WX150G-P2',2025,'4T-OHC','150 CC','11/8000',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-wx150g-p2.jpg','Negro','Modelo todo terreno 150cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','12/6500','Disco/Disco','10L','3.00-18 4.10-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WX150G-P2' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='WX150G-P2') AND (brakes IS NULL OR brakes='');

-- CROSS 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','CROSS 200',2025,'4T-OHC','200 CC','15/7500',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-cross-200.jpg','Gris','Modelo cross todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000','Disco/Disco','11L','80/100-21 110/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='CROSS 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='CROSS 200') AND (brakes IS NULL OR brakes='');

-- TT200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','TT200',2025,'4T-OHC','200 CC','15/7500',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-tt200.jpg','Rojo/Negro','Modelo todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000','Disco/Disco','11L','80/100-21 110/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='TT200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='TT200') AND (brakes IS NULL OR brakes='');

-- 100G-7
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','100G-7',2025,'4T-OHC','100 CC','7.5/8000',0,'Todo Terreno','4 velocidades','/uploads/motos/wanxin-100g-7.jpg','Rojo','Modelo todo terreno 100cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','8.2/6500','Tambor/Tambor','8L','2.75-21 4.10-18','4 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='100G-7' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Tambor/Tambor' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='100G-7') AND (brakes IS NULL OR brakes='');

-- WX200G-8S
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WX200G-8S',2025,'4T-OHC','200 CC','15/7500',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-wx200g-8s.jpg','Negro','Modelo todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000','Disco/Disco','11L','80/100-21 110/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WX200G-8S' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='WX200G-8S') AND (brakes IS NULL OR brakes='');

-- WX200G-8E
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WX200G-8E',2025,'4T-OHC','200 CC','15/7500',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-wx200g-8e.jpg','Rojo','Modelo todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000','Disco/Disco','11L','80/100-21 110/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WX200G-8E' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='WX200G-8E') AND (brakes IS NULL OR brakes='');

-- WX200G-4GE
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WX200G-4GE',2025,'4T-OHC','200 CC','15/7500',0,'Todo Terreno','5 velocidades','/uploads/motos/wanxin-wx200g-4ge.jpg','Negro','Modelo todo terreno 200cc',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000','Disco/Disco','11L','80/100-21 110/90-18','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WX200G-4GE' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);
UPDATE motorcycle_specs SET brakes='Disco/Disco' WHERE motorcycle_id=(SELECT id FROM motorcycles WHERE brand='WANXIN' AND model='WX200G-4GE') AND (brakes IS NULL OR brakes='');

-- WK125-17
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK125-17',2025,'4T OHC','125 CC','10.8/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk125-17.jpg','Red','Motocicleta 125cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','10.8/6000',NULLIF('N/A','N/A'),'14L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK125-17' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SKYWALKER 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','SKYWALKER 250',2025,'4T OHC','250 CC','17/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-skywalker-250.jpg','Blue','Motocicleta 250cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','20/6000',NULLIF('N/A','N/A'),'18L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='SKYWALKER 250' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK110-6A
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK110-6A',2025,'4T OHC','110 CC','7.5/8000',0,'Standard','4 velocidades','/uploads/motos/wanxin-wk110-6a.jpg','Red','Motocicleta 110cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','7.8/6000',NULLIF('N/A','N/A'),'4.2L','N/A','4 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK110-6A' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK150-CB
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK150-CB',2025,'4T OHC','150 CC','11/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk150-cb.jpg','Red','Motocicleta 150cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','12/6000',NULLIF('N/A','N/A'),'12L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK150-CB' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- COBRA 200 GT
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','COBRA 200 GT',2025,'4T OHC','200 CC','15.5/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-cobra-200-gt.jpg','Orange','Motocicleta 200cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000',NULLIF('N/A','N/A'),'16L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='COBRA 200 GT' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK200-8M
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK200-8M',2025,'4T OHC','200 CC','15.5/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk200-8m.jpg','Black','Motocicleta 200cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000',NULLIF('N/A','N/A'),'16L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK200-8M' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- REBEL 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','REBEL 200',2025,'4T OHC','200 CC','15.5/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-rebel-200.jpg','Black','Motocicleta 200cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000',NULLIF('N/A','N/A'),'16L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='REBEL 200' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ASH 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','ASH 150',2025,'4T OHC','150 CC','11/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-ash-150.jpg','Green','Motocicleta 150cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','12/6000',NULLIF('N/A','N/A'),'12L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='ASH 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK125-LT
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK125-LT',2025,'4T OHC','125 CC','10.8/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk125-lt.jpg','Red','Motocicleta 125cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','10.8/6000',NULLIF('N/A','N/A'),'14L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK125-LT' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK110-18
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK110-18',2025,'4T OHC','110 CC','7.5/8000',0,'Standard','4 velocidades','/uploads/motos/wanxin-wk110-18.jpg','Red','Motocicleta 110cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','7.8/6000',NULLIF('N/A','N/A'),'4.2L','N/A','4 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK110-18' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK125L-2
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK125L-2',2025,'4T OHC','125 CC','10.8/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk125l-2.jpg','Red','Motocicleta 125cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','10.8/6000',NULLIF('N/A','N/A'),'14L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK125L-2' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK200-G5
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK200-G5',2025,'4T OHC','200 CC','15.5/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk200-g5.jpg','Yellow','Motocicleta 200cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000',NULLIF('N/A','N/A'),'16L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK200-G5' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ATLW 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','ATLW 150',2025,'4T OHC','150 CC','11/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-atlw-150.jpg','Red','Motocicleta 150cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','12/6000',NULLIF('N/A','N/A'),'12L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='ATLW 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- COBRA 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','COBRA 150',2025,'4T OHC','150 CC','11/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-cobra-150.jpg','Red','Motocicleta 150cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','12/6000',NULLIF('N/A','N/A'),'12L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='COBRA 150' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- WK200-G2
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('WANXIN','WK200-G2',2025,'4T OHC','200 CC','15.5/8000',0,'Standard','5 velocidades','/uploads/motos/wanxin-wk200-g2.jpg','Red','Motocicleta 200cc con ignición CDI',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires, gearbox, gallery)
SELECT id,'N/A','16.8/6000',NULLIF('N/A','N/A'),'16L','N/A','5 velocidades',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='WANXIN' AND m.model='WK200-G2' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- =============================================================
-- Ajuste de secuencias
-- =============================================================
SELECT setval('motorcycles_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycle_specs));



-- =============================================================
-- Catálogo B52 (idempotente)
-- Fuente: bloque legacy en tienda_motos.sql (modelos 2024/2025 y preventas)
-- =============================================================
-- Convenciones:
-- * Se preservan textos originales (engine, power, brakes, etc.)
-- * style: se toma literal del legacy; si era 'N/A' se deja 'N/A'
-- * transmission se usa tal cual; para scooters: 'Automática'
-- * image_url: slug /uploads/motos/b52-{slug}.jpg (placeholder)
-- * gallery: arreglo vacío para futura carga
-- * brakes: si ya se inserta correctamente no es necesario UPDATE, salvo que queramos reforzar
-- * max_speed: se almacena como texto igual que en legacy
-- =============================================================

CATÁLOGO B52 - 2025   :  Split rr 110 , porto 125 ,Apolonia 180 , augusta 200 , augusta 250 , motox 200 , montesa 200 , campera 150 , campera 250 , bombardier 200 , Texas 250 , 
nitrox t3 250 , 

-- CATÁLOGO B52 - 2025

-- 1. SPLIT RR 110
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','SPLIT RR 110',2025,'106.7cc, 4T OHC','106.7cc','6.5 HP/8000 RPM',0,'Urbana','4 velocidades con protección de alta velocidad','/uploads/motos/split-rr-110.jpg','Varios colores disponibles','Moto urbana eficiente y económica',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','3.5 litros','Tambor / Tambor','Analógico','No', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='SPLIT RR 110'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 2. PORTO 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','PORTO 125',2025,'125cc, 4T OHC','125cc','8.04 HP/7000 RPM',0,'Scooter','Automática','/uploads/motos/porto-125.jpg','Varios colores disponibles','Scooter automático con alarma y puerto USB',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Hidráulica / Hidráulica','2.6 litros','Disco / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='PORTO 125'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 3. APOLONIA 180
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','APOLONIA 180',2025,'180cc, 4T OHC a cadenilla','180cc','14.48 HP',0,'Street','Mecánica 5 velocidades','/uploads/motos/apolonia-180.jpg','Varios colores disponibles','Street con faro LED principal y cargador USB',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','2.83 galones','Disco ventilado doble pistón / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='APOLONIA 180'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 4. AUGUSTA 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','AUGUSTA 200',2025,'200cc, 4T OHC a cadenilla','200cc','16 HP',0,'Naked','Mecánica 6 velocidades','/uploads/motos/augusta-200.jpg','Negro brillante, Negro mate','Naked deportiva con slider y doble disco',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','3.3 galones','Disco ventilado doble pistón / Disco ventilado','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='AUGUSTA 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 5. AUGUSTA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','AUGUSTA 250',2025,'250cc, 4T OHC a cadenilla','250cc','17 HP',0,'Naked','Mecánica 6 velocidades','/uploads/motos/augusta-250.jpg','Varios colores disponibles','Naked con radiador de aceite y barras invertidas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas invertidas / Monoshock','3.69 galones','Disco ventilado doble pistón / Disco ventilado','Analógico-Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='AUGUSTA 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 6. MOTOX 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','MOTOX 200',2025,'200cc, 4T OHV con balanceador','200cc','16 HP',0,'Enduro','Mecánica 5 velocidades','/uploads/motos/motox-200.jpg','Varios colores disponibles','Enduro con slider y protector de manubrio',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','3.17 galones','Disco ventilado / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='MOTOX 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 7. MONTESA 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','MONTESA 200',2025,'200cc, 4T OHV con balanceador','200cc','16 HP',0,'Enduro','Mecánica 5 velocidades','/uploads/motos/montesa-200.jpg','Varios colores disponibles','Enduro con slider y protector de barras telescópicas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','3.17 galones','Disco ventilado / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='MONTESA 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 8. CAMPERA 150
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','CAMPERA 150',2025,'144.6cc, 4T OHC','144.6cc','11.58 HP/8500 RPM',0,'Enduro','Mecánica 5 velocidades','/uploads/motos/campera-150.jpg','Varios colores disponibles','Enduro con tablero digital y luz LED delantera IODO',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Monotubo ajustable / Monocilindrico hidráulico','9.10 litros','Disco / Disco','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='CAMPERA 150'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 9. CAMPERA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','CAMPERA 250',2025,'250cc, 4T OHC','250cc','18.77 HP/8000 RPM',0,'Enduro','Mecánica 5 velocidades','/uploads/motos/campera-250.jpg','Varios colores disponibles','Enduro con barras invertidas y sistema de escape Power Boom',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas / Monoshock sistema Prolink','7.8 litros','Disco ventilado / Disco ventilado','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='CAMPERA 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 10. BOMBARDIER 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','BOMBARDIER 200',2025,'200cc, 4T OHC a cadenilla','200cc','16 HP',0,'Cruiser','Mecánica 5 velocidades','/uploads/motos/bombardier-200.jpg','Varios colores disponibles','Cruiser con radiador de aceite y posición de manejo ergonómico',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','4.5 galones','Disco ventilado doble pistón / Tambor','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='BOMBARDIER 200'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 11. TEXAS 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','TEXAS 250',2025,'250cc, 4T SOHC Euro III','250cc','16.8 HP',0,'Cruiser','Mecánica 6 velocidades','/uploads/motos/texas-250.jpg','Varios colores disponibles','Cruiser con inyección electrónica y frenos CBS',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','2.5 galones','Disco ventilado triple pistón / Disco ventilado CBS doble pistón','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='TEXAS 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- 12. NITROX T3 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','NITROX T3 250',2025,'250cc, 4T OHV','250cc','18 HP',0,'Naked','Mecánica 5 velocidades','/uploads/motos/nitrox-t3-250.jpg','Varios colores disponibles','Naked con Bluetooth, alarma y soporte para teléfono',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','3.5 galones','Disco ventilado doble pistón / Disco ventilado doble pistón','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='NITROX T3 250'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- =============================================================
-- Ajuste de secuencias
-- =============================================================
SELECT setval('motorcycles_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycle_specs));

