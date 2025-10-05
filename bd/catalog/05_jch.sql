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
