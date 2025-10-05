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
