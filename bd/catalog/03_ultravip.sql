-- =============================================================
-- Catálogo ULTRAVIP (idempotente)
-- Requiere: schema/01_schema.sql (ya crea índice único)
-- Ejecutar después de seeds mínimos.
-- =============================================================

-- TEKKEN 125CC SEMIAUTOMÁTICO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','TEKKEN 125CC SEMIAUTOMÁTICO',2025,'125cc, 4T','125cc','7.4 HP/8000 RPM',0,'Scooter','4 velocidades','/uploads/motos/tekken-125cc.jpg','Varios colores disponibles','Tu compañera ideal para moverte con rapidez y seguridad',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, fuel_capacity, brakes, dashboard, led_lights, gallery)
SELECT id,'Horquillas telescópicas','13.5 LT','Disco / Tambor','Analógico','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='TEKKEN 125CC SEMIAUTOMÁTICO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- TEKKEN 250 PRO
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','TEKKEN 250 PRO',2025,'250cc balanceado, 4 válvulas, euro 4','250cc','19.5 HP/8300 RPM',0,'Enduro','6 velocidades','/uploads/motos/tekken-250-pro.jpg','Varios colores disponibles','Toma el control, siente el poder en cada aceleración',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, gallery)
SELECT id,'Barras invertidas','Disco / Disco','12.5 LT','Digital','Sí', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='TEKKEN 250 PRO'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ENDURO 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','ENDURO 250CC',2025,'250cc balanceado, 4T, euro 4, OHC','250cc','18 HP/8200 RPM',0,'Enduro','6 velocidades','/uploads/motos/enduro-250cc.jpg','Varios colores disponibles','La potencia que desafía cualquier terreno',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Disco / Disco','12 LT','Digital','Sí','Slider con luces neblineras, luces exploradoras', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='ENDURO 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SPORT 400CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','SPORT 400CC',2025,'400cc bicilíndrico, inyectada, 4T, euro 4, OHC','400cc','33 HP/8300 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/sport-400cc.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas regulables','Doble disco / Disco','16.5 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='SPORT 400CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SPORT 300CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','SPORT 300CC',2025,'300cc inyectada, 4T, euro 4, OHC','300cc','27 HP/8600 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/sport-300cc.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas regulables','Doble disco / Disco','13 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='SPORT 300CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SPORT 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','SPORT 250CC',2025,'250cc inyectada, 4T, euro 4, OHC','250cc','23 HP/7400 RPM',0,'Deportiva','6 velocidades balanceado','/uploads/motos/sport-250cc.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas regulables','Doble disco / Disco','13 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='SPORT 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- SCOOTER 125CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','SCOOTER 125CC',2025,'125cc, 4T','125cc','7.4 HP/8000 RPM',0,'Scooter','4 velocidades','/uploads/motos/scooter-125cc.jpg','Varios colores disponibles','Máximo rendimiento con el mínimo esfuerzo',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Tambor','13.5 LT','Digital','Sí','Luz exploradora, parlantes, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='SCOOTER 125CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- NAKED 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','NAKED 250CC',2025,'250cc balanceado, 4T, euro 4, OHC','250cc','23 HP/7400 RPM',0,'Naked','6 velocidades','/uploads/motos/naked-250cc.jpg','1 color disponible','Enciende el motor y crea tu propio camino',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Disco / Disco','14 LT','Digital','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='NAKED 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ADVENTURE 400CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','ADVENTURE 400CC',2025,'400cc bicilíndrica, inyectada, balanceado, 4T, euro 4, OHC','400cc','33 HP/8300 RPM',0,'Adventure','6 velocidades','/uploads/motos/adventure-400cc.jpg','Varios colores disponibles','Menos consumo, más rendimiento, máxima emoción',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Doble disco / Disco','16.5 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='ADVENTURE 400CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ADVENTURE 300CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','ADVENTURE 300CC',2025,'300cc inyectada, balanceado, 4T, euro 4, OHC','300cc','27 HP/8600 RPM',0,'Adventure','6 velocidades','/uploads/motos/adventure-300cc.jpg','Varios colores disponibles','Diseñadas para quienes exigen el máximo rendimiento',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Doble disco / Disco','13 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='ADVENTURE 300CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- ADVENTURE 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','ADVENTURE 250CC',2025,'250cc inyectada, balanceado, 4T, euro 4, OHC','250cc','23 HP/7400 RPM',0,'Adventure','6 velocidades','/uploads/motos/adventure-250cc.jpg','Varios colores disponibles','Eficiencia, precisión y agresividad sobre dos ruedas',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Doble disco / Disco','13 LT','Digital TFT','Sí','Slider con luces neblineras, puerto USB y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='ADVENTURE 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- STREET 200CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','STREET 200CC',2025,'200cc balanceado, 4T, euro 4','200cc','16 HP/8000 RPM',0,'Street','6 velocidades','/uploads/motos/street-200cc.jpg','Varios colores disponibles','Arranca, acelera y disfruta sin distracciones',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Tambor','12 LT','Mixto','Sí','Slider con luces neblineras', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='STREET 200CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- TRAIL 200CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','TRAIL 200CC',2025,'200cc balanceado, 4T','200cc','11 HP/8000 RPM',0,'Trail','6 velocidades','/uploads/motos/trail-200cc.jpg','Varios colores disponibles','Arranca el motor, deja el miedo atrás y conquista el camino',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Tambor','12 LT','Digital','No','Protector para motor y faro', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='TRAIL 200CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- TRAIL 150CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','TRAIL 150CC',2025,'150cc, 4T','150cc','8.5 HP/7500 RPM',0,'Trail','5 velocidades','/uploads/motos/trail-150cc.jpg','Varios colores disponibles','La mejor opción para recorrer la ciudad sin límite',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Tambor','12 LT','Digital','Sí','Protector para motor y faro', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='TRAIL 150CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- STREET TOURING 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','STREET TOURING 250CC',2025,'250cc balanceado, 4T, euro 4, OHC','250cc','18 HP/8500 RPM',0,'Touring','6 velocidades','/uploads/motos/street-touring-250cc.jpg','Varios colores disponibles','Conduce a tu manera, con estilo y precisión',TRUE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Disco','15 LT','Digital','Sí','Slider con luces neblineras', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='STREET TOURING 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- STREET TOURING 200CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','STREET TOURING 200CC',2025,'200cc balanceado, 4T, euro 4, OHC','200cc','16 HP/8000 RPM',0,'Touring','6 velocidades','/uploads/motos/street-touring-200cc.jpg','Varios colores disponibles','Pisando fuerte, acelerando con determinación',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Horquillas telescópicas','Disco / Disco','13.5 LT','Digital','Sí','Slider con luces neblineras', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='STREET TOURING 200CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- RACING 200CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','RACING 200CC',2025,'200cc balanceado, 4T, euro 4, OHC','200cc','16.5 HP/8300 RPM',0,'Racing','6 velocidades','/uploads/motos/racing-200cc.jpg','Varios colores disponibles','Para los que viven con el acelerador a fondo',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Disco / Disco','15 LT','Digital','Sí','Slider con luces neblineras, parlantes y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='RACING 200CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- RACING 250CC
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('ULTRAVIP','RACING 250CC',2025,'250cc balanceado, 4T, euro 4, OHC','250cc','18 HP/8500 RPM',0,'Racing','6 velocidades','/uploads/motos/racing-250cc.jpg','Varios colores disponibles','La pista es tuya, exprime cada kilómetro',FALSE)
ON CONFLICT (brand, model) DO NOTHING;
INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, dashboard, led_lights, accessories, gallery)
SELECT id,'Barras invertidas','Disco / Disco','15 LT','Digital','Sí','Slider con luces neblineras, parlantes y alarma', ARRAY[]::text[] FROM motorcycles m
WHERE m.brand='ULTRAVIP' AND m.model='RACING 250CC'
AND NOT EXISTS (SELECT 1 FROM motorcycle_specs s WHERE s.motorcycle_id=m.id);

-- Ajuste secuencias (opcional)
SELECT setval('motorcycles_id_seq', (SELECT MAX(id) FROM motorcycles));
SELECT setval('motorcycle_specs_id_seq', (SELECT MAX(id) FROM motorcycle_specs));
