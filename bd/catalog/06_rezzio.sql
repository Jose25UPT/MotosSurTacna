

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
