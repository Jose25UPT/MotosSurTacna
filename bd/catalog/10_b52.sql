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

-- B52-107CC (PREVENTA)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','B52-107CC',2025,'4T OHC','106.7cc','6.5 HP / 8000 RPM',0,'N/A','4 velocidades','/uploads/motos/b52-b52-107cc.jpg','N/A','PREVENTA',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','Tambor / Tambor','3.5 litros','85 KM/H','2.50-17 / 2.75-17','Analógico',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='B52-107CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SCOOTER 125CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','SCOOTER 125CC',2025,'4T OHC','125cc','8.04 HP / 7000 RPM',0,'Scooter','Automática','/uploads/motos/b52-scooter-125cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Hidráulica / Hidráulica','Disco / Tambor','2.6 litros','80 KM/H','3.50-10 / 3.50-10','N/A',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='SCOOTER 125CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- DEPORTIVO 180CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','DEPORTIVO 180CC',2025,'4T OHC a cadenilla','180cc','14.48 HP',0,'Deportiva','5 velocidades','/uploads/motos/b52-deportivo-180cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','Disco ventilado doble pistón / Tambor mecánico','2.83 galones','115 KM/H','90-90-17 / 110-80-17','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='DEPORTIVO 180CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- DEPORTIVO 200CC (PREVENTA)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','DEPORTIVO 200CC',2025,'4T OHC a cadenilla','200cc','16 HP',0,'Deportiva','6 velocidades','/uploads/motos/b52-deportivo-200cc.jpg','Negro brillante, negro mate','PREVENTA',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','Disco ventilado doble pistón / Disco ventilado un pistón','3.3 galones','115 KM/H','100-90-17 / 130-80-17','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='DEPORTIVO 200CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- DEPORTIVO 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','DEPORTIVO 250CC',2025,'4T OHC a cadenilla','250cc','17 HP',0,'Deportiva','6 velocidades','/uploads/motos/b52-deportivo-250cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas invertidas / Monoshock','Disco ventilado doble pistón / Disco ventilado un pistón','3.69 galones','130 KM/H','110-90-17 / 130-80-17','Analógico-digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='DEPORTIVO 250CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ENDURO/CROSS 200CC V1 (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','ENDURO/CROSS 200CC V1',2025,'4T OHV con balanceador','200cc','16 HP',0,'Enduro/Cross','5 velocidades','/uploads/motos/b52-enduro-cross-200cc-v1.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','Disco ventilado un pistón / Tambor mecánico','3.17 galones','110 KM/H','19" / 17"','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='ENDURO/CROSS 200CC V1' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ENDURO/CROSS 200CC V2 (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','ENDURO/CROSS 200CC V2',2025,'4T OHV con balanceador','200cc','16 HP',0,'Enduro/Cross','5 velocidades','/uploads/motos/b52-enduro-cross-200cc-v2.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','Disco ventilado un pistón / Tambor mecánico','3.17 galones','110 KM/H','110-100-17 / 120-100-17','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='ENDURO/CROSS 200CC V2' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ENDURO/CROSS 145CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','ENDURO/CROSS 145CC',2025,'4T OHC','144.6cc','11.58 HP / 8500 RPM',0,'Enduro/Cross','5 velocidades','/uploads/motos/b52-enduro-cross-145cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Monotubo ajustable / Monocilíndrico hidráulico','Disco / Disco','9.10 litros','90 KM/H','80-100-21 / 100-100-18','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='ENDURO/CROSS 145CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ENDURO/CROSS 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','ENDURO/CROSS 250CC',2025,'4T OHC','250cc','18.77 HP / 8000 RPM',0,'Enduro/Cross','5 velocidades','/uploads/motos/b52-enduro-cross-250cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Barras invertidas / Monoshock','Disco ventilado / Disco ventilado','7.8 litros','N/A','80-100-21 / 100-100-18','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='ENDURO/CROSS 250CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- CRUISER 200CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','CRUISER 200CC',2025,'4T OHC a cadenilla','200cc','16 HP',0,'Cruiser','5 velocidades','/uploads/motos/b52-cruiser-200cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','Disco ventilado doble pistón / Tambor mecánico','4.5 galones','110 KM/H','110-90-16 / 130-90-15','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='CRUISER 200CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SCOOTER 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','SCOOTER 250CC',2025,'4T SOHC Euro III','250cc','16.8 HP',0,'Scooter','6 velocidades','/uploads/motos/b52-scooter-250cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Doble amortiguador','Disco ventilado triple pistón / Disco ventilado CBS doble pistón','2.5 galones','120 KM/H','100-90-16 / 130-90-15','N/A',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='SCOOTER 250CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- NAKED/STREET 250CC (VERSIÓN 2024)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52','NAKED/STREET 250CC',2024,'4T OHV','250cc','18 HP',0,'Naked/Street','5 velocidades','/uploads/motos/b52-naked-street-250cc.jpg','N/A','N/A',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard, gallery)
SELECT id,'Horquillas telescópicas / Monoshock','Disco ventilado doble pistón / Disco ventilado doble pistón','3.5 galones','130 KM/H','110-80-17 / 140-70-17','Digital',ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='B52' AND m.model='NAKED/STREET 250CC' AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- =============================================================
-- Ajuste de secuencias
-- =============================================================
SELECT setval('motorcycles_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT COALESCE(MAX(id),1) FROM motorcycle_specs));
