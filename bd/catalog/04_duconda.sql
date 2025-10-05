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
