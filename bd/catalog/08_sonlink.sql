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
