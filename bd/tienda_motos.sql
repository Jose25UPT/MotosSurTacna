-- =============================
-- ESTRUCTURA FINAL CON APARTADO SOBRE LA MARCA Y AJUSTES
-- =============================

-- Elimina tablas previas si existen
DROP TABLE IF EXISTS motorcycle_specs CASCADE;
DROP TABLE IF EXISTS motorcycles CASCADE;
DROP TABLE IF EXISTS brand_info CASCADE;

-- Tabla de información sobre la marca (sección "Sobre la marca")
CREATE TABLE IF NOT EXISTS brand_info (
    id SERIAL PRIMARY KEY, -- No visible
    brand VARCHAR(100) NOT NULL UNIQUE, -- Marca
    about TEXT NOT NULL -- Sobre la marca (parrafo)
);

-- Tabla principal de motos (card y detalles)
CREATE TABLE IF NOT EXISTS motorcycles (
    id SERIAL PRIMARY KEY, -- Card y detalles
    brand VARCHAR(100) NOT NULL, -- Card y detalles
    model VARCHAR(100) NOT NULL, -- Card y detalles
    year INT NOT NULL, -- Card y detalles
    engine VARCHAR(100) DEFAULT 'N/A', -- Card y detalles
    displacement VARCHAR(50) DEFAULT 'N/A', -- Detalles
    power VARCHAR(50) DEFAULT 'N/A', -- Detalles
    price_soles NUMERIC(12,2) NOT NULL, -- Card y detalles (solo soles)
    style VARCHAR(50) DEFAULT 'N/A', -- Detalles
    transmission VARCHAR(50) DEFAULT 'N/A', -- Detalles
    image_url TEXT NOT NULL, -- Card y detalles (imagen principal)
    color VARCHAR(100) DEFAULT 'N/A', -- Card y detalles
    description TEXT DEFAULT 'N/A', -- Card y detalles
    is_active BOOLEAN DEFAULT TRUE, -- Card y detalles
    created_at TIMESTAMP DEFAULT NOW(), -- No visible
    updated_at TIMESTAMP DEFAULT NOW()  -- No visible
);

-- Tabla de especificaciones técnicas y galería (detalles)
CREATE TABLE IF NOT EXISTS motorcycle_specs (
    id SERIAL PRIMARY KEY, -- Detalles
    motorcycle_id INTEGER REFERENCES motorcycles(id) ON DELETE CASCADE, -- Detalles
    suspension VARCHAR(100) DEFAULT 'N/A', -- Detalles
    telescopic_forks VARCHAR(100) DEFAULT 'N/A', -- Detalles
    length VARCHAR(50) DEFAULT 'N/A', -- Detalles
    width VARCHAR(50) DEFAULT 'N/A', -- Detalles
    height VARCHAR(50) DEFAULT 'N/A', -- Detalles
    max_speed VARCHAR(50) DEFAULT 'N/A', -- Detalles
    max_torque VARCHAR(50) DEFAULT 'N/A', -- Detalles
    brakes VARCHAR(100) DEFAULT 'N/A', -- Detalles
    fuel_capacity VARCHAR(50) DEFAULT 'N/A', -- Detalles
    tires VARCHAR(100) DEFAULT 'N/A', -- Detalles
    start_type VARCHAR(50) DEFAULT 'N/A', -- Detalles
    tank VARCHAR(50) DEFAULT 'N/A', -- Detalles
    dashboard VARCHAR(100) DEFAULT 'N/A', -- Detalles
    ohc VARCHAR(50) DEFAULT 'N/A', -- Detalles
    digital_dashboard VARCHAR(50) DEFAULT 'N/A', -- Detalles
    alarm VARCHAR(50) DEFAULT 'N/A', -- Detalles
    ignition VARCHAR(50) DEFAULT 'N/A', -- Detalles
    usb VARCHAR(50) DEFAULT 'N/A', -- Detalles
    led_lights VARCHAR(50) DEFAULT 'N/A', -- Detalles
    gearbox VARCHAR(50) DEFAULT 'N/A', -- Detalles
    gallery TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[], -- Galería de imágenes (detalles)
    created_at TIMESTAMP DEFAULT NOW(), -- No visible
    updated_at TIMESTAMP DEFAULT NOW()  -- No visible
);



-- Insertar información de marca
INSERT INTO brand_info (brand, about) VALUES
    ('Honda', 'Honda es una de las marcas líderes en motocicletas a nivel mundial, reconocida por su innovación y calidad.'),
    ('Yamaha', 'Yamaha destaca por su tecnología avanzada y su presencia global en el mundo de las motos.'),
    ('ADVANCE', 'ADVANCE es una marca nacional que ofrece motocicletas robustas y confiables, especialmente diseñadas para el terreno peruano.'),
    ('B52', 'B52 es una marca moderna que combina diseño deportivo con tecnología avanzada, ofreciendo motocicletas de alta calidad.'),
    ('WANXIN', 'WANXIN se especializa en motocicletas de alta calidad con tecnología moderna y diseño innovador.'),
    ('ZONGSHEN', 'ZONGSHEN es una marca china reconocida mundialmente por su calidad y tecnología en motocicletas.'),
    ('QINGQI', 'QINGQI ofrece motocicletas versátiles y eficientes, ideales para el uso urbano y deportivo.'),
    ('HAOJUE', 'HAOJUE es conocida por sus motocicletas confiables y de excelente rendimiento.'),
    ('JIANSHE', 'JIANSHE produce motocicletas duraderas y económicas, perfectas para el transporte diario.'),
    ('LIFAN', 'LIFAN se destaca por ofrecer motocicletas con excelente relación calidad-precio y tecnología moderna.');

-- Insertar una moto con imagen local subida

INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
    'Honda', 'CBR250R', 2023, 'Monocilíndrico 4T', '249cc', '27 HP', 18500.00, 'Deportiva', '6 velocidades',
    '/uploads/motos/honda-cbr250r.jpg', 'Rojo', 'Motocicleta deportiva de alta calidad con excelente rendimiento.', TRUE
);

-- Insertar especificaciones técnicas y galería para la moto anterior
INSERT INTO motorcycle_specs (motorcycle_id, suspension, length, width, height, max_speed, max_torque, brakes, fuel_capacity, tires, start_type, gallery)
VALUES (
    (SELECT id FROM motorcycles WHERE brand = 'Honda' AND model = 'CBR250R' LIMIT 1), 
    'Delantera telescópica / Monoamortiguador', '2030mm', '720mm', '1120mm', '145 km/h', '23 Nm', 'Disco / Disco', '13L', '110/70-17 / 140/70-17', 'Eléctrico y pedal',
    ARRAY['/uploads/motos/honda-cbr250r-1.jpg', '/uploads/motos/honda-cbr250r-2.jpg', '/uploads/motos/honda-cbr250r-3.jpg']
);

-- Insertar otra moto y sus especificaciones

INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
    'Yamaha', 'FZ25', 2024, 'Monocilíndrico 4T', '249cc', '20.8 HP', 16800.00, 'Naked', '5 velocidades',
    '/uploads/motos/yamaha-fz25.jpg', 'Negro', 'Motocicleta naked con diseño moderno y gran maniobrabilidad.', TRUE
);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, length, width, height, max_speed, max_torque, brakes, fuel_capacity, tires, start_type, gallery)
VALUES (
    (SELECT id FROM motorcycles WHERE brand = 'Yamaha' AND model = 'FZ25' LIMIT 1), 
    'Delantera telescópica / Monoamortiguador', '2015mm', '770mm', '1075mm', '134 km/h', '20 Nm', 'Disco / Tambor', '14L', '100/80-17 / 140/60-17', 'Eléctrico',
    ARRAY['/uploads/motos/yamaha-fz25-1.jpg', '/uploads/motos/yamaha-fz25-2.jpg']
);

-- =============================
-- FIN DE EJEMPLOS
-- =============================
-- =============================
-- INSERCIONES DE MOTOS MARCA ADVANCE
-- =============================

-- ENDURO 200X
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'ENDURO 200X', 2025, 'Monocilíndrico OHC 4T', '200 cc', '16 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Rojo', 'N/A', TRUE
);

-- TEKEN 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'TEKEN 250', 2025, 'Monocilíndrico OHC 4T', '249 cc', '20 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Rojo, Verde, Negro', 'N/A', TRUE
);

-- ADVENGER 200Z
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'ADVENGER 200Z', 2025, 'Monocilíndrico OHC 4T', '198 cc', '14.3 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Rojo, Negro', 'N/A', TRUE
);

-- NINDIA 200S
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'NINDIA 200S', 2025, 'Monocilíndrico OHC 4T', '200 cc', '17.20 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Verde, Naranja, Blanco', 'N/A', TRUE
);

-- JAGUAR 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'JAGUAR 200', 2025, 'Monocilíndrico OHC 4T', '200 cc', '15.7 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Rojo, Verde, Negro', 'N/A', TRUE
);

-- ZEUS 200Z
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'ZEUS 200Z', 2025, 'Monocilíndrico OHC 4T', '200 cc', '17.20 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Rojo, Negro', 'N/A', TRUE
);

-- NINDIA 250 R7
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'NINDIA 250 R7', 2025, 'Monocilíndrico OHC 4T', '250 cc', '18 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Marrón, Negro', 'N/A', TRUE
);

-- NINDIA 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'NINDIA 250', 2025, 'Monocilíndrico OHC 4T', '249.6 cc', '15.4 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Verde, Azul, Rojo, Negro', 'N/A', TRUE
);

-- BULTACO 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'BULTACO 250', 2025, 'Monocilíndrico OHC 4T', '250 cc', '16.3 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Negro', 'N/A', TRUE
);

-- SCRAMPER 250
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'SCRAMPER 250', 2025, 'Monocilíndrico OHC 4T', '250 cc', '16 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Blanco, Negro', 'N/A', TRUE
);

-- SCRAMPLER 200
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'SCRAMPLER 200', 2025, 'Monocilíndrico OHC 4T', '200 cc', '15 HP / 7500 rpm', 0, 'Enduro', 'Cadena', 'N/A', 'Blanco, Negro', 'N/A', TRUE
);

-- AD150 T-6
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'AD150 T-6', 2025, 'Monocilíndrico OHC 4T', '150 cc', '9.3 HP / 7500 rpm', 0, 'Scooter', 'Automática',  'N/A', 'Rojo, Negro', 'N/A', TRUE
);

-- SUPER MEGAN 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'SUPER MEGAN 125', 2025, 'Monocilíndrico OHC 4T', '125 cc', '9.3 HP / 7500 rpm', 0, 'Scooter', 'Semi automática', 'N/A', 'Azul, Rojo, Negro', 'N/A', TRUE
);

-- ASHLEY 125
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (
  'ADVANCE', 'ASHLEY 125', 2025, 'Monocilíndrico OHC 4T', '125 cc', '9.3 HP / 7500 rpm', 0, 'Scooter', 'Semi automática', 'N/A', 'Rojo, Negro', 'N/A', TRUE
);

-- =============================
-- Especificaciones técnicas (debes reemplazar los IDs por los reales)
-- =============================

-- ENDURO 200X
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'ENDURO 200X' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '14 L', 'Eléctrico y pedal', 'Analógico', '115 km/h',
  ARRAY['N/A']
);

-- TEKEN 250
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'TEKEN 250' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '120 km/h',
  ARRAY['N/A']
);

-- ADVENGER 200Z
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'ADVENGER 200Z' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '14 L', 'Eléctrico', 'Analógico', '120 km/h',
  ARRAY['N/A']
);

-- NINDIA 200S
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'NINDIA 200S' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '14 L', 'Eléctrico y pedal', 'Digital', '120 km/h',
  ARRAY['N/A']
);

-- JAGUAR 200
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'JAGUAR 200' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '14 L', 'Eléctrico y pedal', 'Digital', '115 km/h',
  ARRAY['N/A']
);

-- ZEUS 200Z
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'ZEUS 200Z' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '15 L', 'Eléctrico y pedal', 'Digital', '120 km/h',
  ARRAY['N/A']
);

-- NINDIA 250 R7
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'NINDIA 250 R7' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '135 km/h',
  ARRAY['N/A']
);

-- NINDIA 250
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'NINDIA 250' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '130 km/h',
  ARRAY['N/A']
);

-- BULTACO 250
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'BULTACO 250' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '115 km/h',
  ARRAY['N/A']
);

-- SCRAMPER 250
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'SCRAMPER 250' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '120 km/h',
  ARRAY['N/A']
);

-- SCRAMPLER 200
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'SCRAMPLER 200' LIMIT 1), 
  'Disco (delantero) / Disco (trasero)', '14 L', 'Eléctrico', 'Digital', '120 km/h',
  ARRAY['N/A']
);

-- AD150 T-6
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'AD150 T-6' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '6 L', 'Eléctrico y pedal', 'Analógico', '115 km/h',
  ARRAY['N/A']
);

-- SUPER MEGAN 125
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'SUPER MEGAN 125' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '6 L', 'Eléctrico y pedal', 'Analógico', '85 km/h',
  ARRAY['N/A']
);

-- ASHLEY 125
INSERT INTO motorcycle_specs (motorcycle_id, brakes, fuel_capacity, start_type, dashboard, max_speed, gallery)
VALUES (
  (SELECT id FROM motorcycles WHERE brand = 'ADVANCE' AND model = 'ASHLEY 125' LIMIT 1), 
  'Disco (delantero) / Tambor (trasero)', '6 L', 'Eléctrico y pedal', 'Analógico', '85 km/h',
  ARRAY['N/A']
);


---------------------------
--------------------------
-------CATALOGO ULTRA VIP--
--------------------------
--------------------------



-- MODELO TEKKEN 125CC SEMIAUTOMÁTICO
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (16, 'TEKKEN 125CC SEMIAUTOMÁTICO', 'Tu compañera ideal para moverte con rapidez y seguridad', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (16, '4 velocidades', '125cc, 4T', '7.4 HP/8000 RPM', NULL, 'Parlantes, puerto USB y alarma', 'Analógico', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '115/80-13*115/80-13', '13.5 LT', 'Parlantes, llantas aro 13, motor 200 de 6 velocidades balanceado, protector de manos con luces LED', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO TEKKEN 250 PRO
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (17, 'TEKKEN 250 PRO', 'Toma el control, siente el poder en cada aceleración', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (2, '6 velocidades', '250cc balanceado, 4 válvulas, euro 4', '19.5 HP/8300 RPM', 'Radiador de aceite', 'Slider con luces neblineras y alarma', 'Digital', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Magnesio', '3.50-17*4.60-17', '12.5 LT', 'Tacómetro digital, llantas multipropósito, motor 300 de 6 velocidades balanceado a 4 válvulas, barras invertidas, slider con luces, neblineras', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO ENDURO 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (18, 'ENDURO 250CC', 'La potencia que desafía cualquier terreno', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (3, '6 velocidades', '250cc balanceado, 4T, euro 4, OHC', '18 HP/8200 RPM', 'Aire', 'Slider con luces neblineras, luces exploradoras', 'Digital', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Aleación', '4.60-17*3.50/50-17', '12 LT', 'Protector de mano con luces LED, faro con protector, motor 250 de 6 velocidades balanceado, barras invertidas, slider con luces neblineras', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO SPORT 400CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (19, 'SPORT 400CC', 'Eficiencia, precisión y agresividad sobre dos ruedas', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (4, '6 velocidades balanceado', '400cc bicilíndrico, inyectada, 4T, euro 4, OHC', '33 HP/8300 RPM', 'Radiador líquido', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas regulables', 'Monoshock', 'Magnesio', '120/70-17*160/70-17', '16.5 LT', 'Panel digital TFT, motor 250 de 6 velocidades balanceado, faro luces LED, trapecio de aleación, frenos de doble disco', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO SPORT 300CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (20, 'SPORT 300CC', 'Eficiencia, precisión y agresividad sobre dos ruedas', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (5, '6 velocidades balanceado', '300cc inyectada, 4T, euro 4, OHC', '27 HP/8600 RPM', 'Radiador de aceite', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas regulables', 'Monoshock', 'Magnesio', '120/70-17*160/70-17', '13 LT', 'Panel digital TFT, motor 250 de 6 velocidades balanceado, faro luces LED, frenos de doble disco, trapecio de aleación', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO SPORT 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (21, 'SPORT 250CC', 'Eficiencia, precisión y agresividad sobre dos ruedas', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (6, '6 velocidades balanceado', '250cc inyectada, 4T, euro 4, OHC', '23 HP/7400 RPM', 'Radiador de aceite', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas regulables', 'Monoshock', 'Magnesio', '120/70-17*160/70-17', '13 LT', 'Panel digital TFT, motor 250 de 6 velocidades balanceado, faro luces LED, frenos de doble disco, trapecio de aleación', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO SCOOTER 125CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (22, 'SCOOTER 125CC', 'Máximo rendimiento con el mínimo esfuerzo', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (7, '4 velocidades', '125cc, 4T', '7.4 HP/8000 RPM', NULL, 'Luz exploradora, parlantes, puerto USB y alarma', 'Digital', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '115/80-13*115/80-13', '13.5 LT', 'Tablero digital, protector de mano, full luces LED, motor 125 de 4 velocidades semiautomático, control de música y alarma, canasta original', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO NAKED 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (23, 'NAKED 250CC', 'Enciende el motor y crea tu propio camino', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (8, '6 velocidades', '250cc balanceado, 4T, euro 4, OHC', '23 HP/7400 RPM', 'Radiador de aceite', 'Slider con luces neblineras, puerto USB y alarma', 'Digital', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Magnesio', '110/70-17*150/70-17', '14 LT', 'Tacómetro digital, motor 250 de 6 velocidades balanceado, faro luces LED, slider con luces neblineras, barras invertidas', 'DISPONIBLE', '1 color disponible');

-- MODELO ADVENTURE 400CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (24, 'ADVENTURE 400CC', 'Menos consumo, más rendimiento, máxima emoción', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (9, '6 velocidades', '400cc bicilíndrica, inyectada, balanceado, 4T, euro 4, OHC', '33 HP/8300 RPM', 'Radiador de agua', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Magnesio', '110/70-17*150/70-17', '16.5 LT', 'Enfriador de aceite, slider con luces neblineras, motor 400 bicilíndrico de 6 velocidades balanceado, tablero TFT, faro luces LED', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO ADVENTURE 300CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (25, 'ADVENTURE 300CC', 'Diseñadas para quienes exigen el máximo rendimiento', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (10, '6 velocidades', '300cc inyectada, balanceado, 4T, euro 4, OHC', '27 HP/8600 RPM', 'Radiador de aceite', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Magnesio', '110/70-17*150/70-17', '13 LT', 'Barras invertidas, freno delantero de doble disco, motor 300 de 6 velocidades balanceado, slider con luces neblineras, faro luces LED', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO ADVENTURE 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (26, 'ADVENTURE 250CC', 'Eficiencia, precisión y agresividad sobre dos ruedas', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (11, '6 velocidades', '250cc inyectada, balanceado, 4T, euro 4, OHC', '23 HP/7400 RPM', 'Radiador de aceite', 'Slider con luces neblineras, puerto USB y alarma', 'Digital TFT', 'Luces LED', 'Barras invertidas', 'Monoshock', 'Magnesio', '110/70-17*150/70-17', '13 LT', 'Freno delantero de doble disco, motor 250 de 6 velocidades balanceado, slider con luces neblineras, barras invertidas, faro luces LED', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO STREET 200CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (27, 'STREET 200CC', 'Arranca, acelera y disfruta sin distracciones', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (12, '6 velocidades', '200cc balanceado, 4T, euro 4', '16 HP/8000 RPM', NULL, 'Slider con luces neblineras', 'Mixto', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '2.75-18*3.00-18', '12 LT', 'Tacómetro mixto, slider con luces neblineras, motor 200 de 6 velocidades balanceado, faro luces LED, protector de manos con luces LED', 'AGOTADO', 'Varios colores disponibles');

-- MODELO TRAIL 200CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (28, 'TRAIL 200CC', 'Arranca el motor, deja el miedo atrás y conquista el camino', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (13, '6 velocidades', '200cc balanceado, 4T', '11 HP/8000 RPM', 'Aire', 'Protector para motor y faro', 'Digital', 'Luces halógenas', 'Horquillas telescópicas', NULL, 'Aleación', '2.75-18*3.00-18', '12 LT', 'Tablero digital, protector de motor, motor 200 de 6 velocidades balanceado, faro de luz halógena con protector, llantas aro N° 18', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO TRAIL 150CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (29, 'TRAIL 150CC', 'La mejor opción para recorrer la ciudad sin límite', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (14, '5 velocidades', '150cc, 4T', '8.5 HP/7500 RPM', 'Aire', 'Protector para motor y faro', 'Digital', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '2.75-18*3.00-18', '12 LT', 'Tacómetro digital, protector de mano, protector de motor, motor 150 de 5 velocidades balanceado, faro de luz halógena con protector', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO STREET TOURING 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (30, 'STREET TOURING 250CC', 'Conduce a tu manera, con estilo y precisión', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (15, '6 velocidades', '250cc balanceado, 4T, euro 4, OHC', '18 HP/8500 RPM', 'Radiador de aceite', 'Slider con luces neblineras', 'Digital', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '100/80-17*130/70-17', '15 LT', 'Faro LED, slider con luces neblineras, motor 250 de 6 velocidades balanceado, panel digital, protector de manos', 'DISPONIBLE', 'Varios colores disponibles');

-- MODELO STREET TOURING 200CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (31, 'STREET TOURING 200CC', 'Pisando fuerte, acelerando con determinación', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (16, '6 velocidades', '200cc balanceado, 4T, euro 4, OHC', '16 HP/8000 RPM', 'Aire', 'Slider con luces neblineras', 'Digital', 'Luces LED', 'Horquillas telescópicas', NULL, 'Aleación', '90/90-17*110/90-17', '13.5 LT', 'Slider con luces neblineras, motor 200 de 6 velocidades balanceado, faro LED, panel digital, enfriador de aceite', 'AGOTADO', 'Varios colores disponibles');

-- MODELO RACING 200CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (32, 'RACING 200CC', 'Para los que viven con el acelerador a fondo', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (17, '6 velocidades', '200cc balanceado, 4T, euro 4, OHC', '16.5 HP/8300 RPM', 'Radiador de aceite', 'Slider con luces neblineras, parlantes y alarma', 'Digital', 'Luces LED', 'Barras invertidas', NULL, 'Aleación', '100/80-17*130/70-17', '15 LT', 'Slider con luces neblineras, motor 200 de 6 velocidades balanceado, faro LED, panel digital, enfriador de aceite', 'AGOTADO', 'Varios colores disponibles');

-- MODELO RACING 250CC
INSERT INTO motorcycles (id, nombre, descripcion, marca) VALUES (33, 'RACING 250CC', 'La pista es tuya, exprime cada kilómetro', 'ULTRAVIP');

INSERT INTO motorcycle_specs (motorcycle_id, transmision, motor, potencia, refrigeracion, accesorios, tacometro, faros, suspension_delantera, suspension_posterior, aros, llantas, capacidad_combustible, caracteristicas_especiales, estado, colores) VALUES (18, '6 velocidades', '250cc balanceado, 4T, euro 4, OHC', '18 HP/8500 RPM', 'Radiador de aceite', 'Slider con luces neblineras, parlantes y alarma', 'Digital', 'Luces LED', 'Barras invertidas', NULL, 'Aleación', '100/80-17*130/70-17', '15 LT', 'Faro LED, slider con luces neblineras, motor 200 de 6 velocidades balanceado, panel digital, enfriador de aceite', 'AGOTADO', 'Varios colores disponibles');

------------------
------------------
----DUCONDA-------
------------------
------------------

-- NEWDUX 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (34, 'DUCONDA', 'NEWDUX 150', 2025, '4 tiempos CVT', '150 cc', '8.3 HP / 7500 r/min', 0.00, 'N/A', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (34, 'Barras telescópicas / Doble amortiguador', 'Barras telescópicas', '190 cm', '68.5 cm', '108.5 cm', '100 km/h');

-- DUVI 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (35, 'DUCONDA', 'DUVI 150', 2025, '4 tiempos CVT', '150 cc', '26 HP / 8500 r/min', 0.00, 'N/A', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (35, 'Barras invertidas / Monoshock', 'Barras invertidas', '203 cm', '85.6 cm', '112.4 cm', '100 km/h');

-- SDUX 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (36, 'DUCONDA', 'SDUX 200', 2025, '4 tiempos OCH', '200 cc', '17 HP / 8000 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (36, 'Barras invertidas / Monoshock', 'Barras invertidas', '185 cm', '85.6 cm', '112.4 cm', '130 km/h');

-- FORTE 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (37, 'DUCONDA', 'FORTE 150', 2025, '4 tiempos CVT', '150 cc', '8.4 HP / 7500 r/min', 0.00, 'N/A', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, max_torque, max_speed)
VALUES (37, 'Barras telescópicas / Doble amortiguador', 'Barras telescópicas', '105 kg / 150 kg', '100 km/h');

-- HORSE/EMPIRE
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (38, 'DUCONDA', 'HORSE/EMPIRE', 2025, '4 tiempos OCH', '150 cc', '11 HP / 8000 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (38, 'Barras invertidas / Monoshock', 'Barras invertidas', '207 cm', '78 cm', '108.5 cm', '100 km/h');

-- DU-R200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (39, 'DUCONDA', 'DU-R200', 2025, '4 tiempos OCH / Balanceador', '200 cc', '17 HP / 8000 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (39, 'Barras invertidas / Monoshock', 'Barras invertidas', '203 cm', '85 cm', '112.4 cm', '130 km/h');

-- DU-300
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (40, 'DUCONDA', 'DU-300', 2025, '4 tiempos OCH / Balanceador', '300 cc', '21 HP / 8500 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (40, 'Barras invertidas / Monoshock', 'Barras invertidas', '203 cm', '85 cm', '112.4 cm', '150 km/h');

-- TEKK 300 PRO
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (41, 'DUCONDA', 'TEKK 300 PRO', 2025, '4 tiempos OCH / Balanceador', '300 cc', '27.3 HP / 8500 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (41, 'Barras invertidas / Monoshock', 'Barras invertidas', '182 cm', '49 cm', '88 cm', '130 km/h');

-- DUCO 250 DT
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (42, 'DUCONDA', 'DUCO 250 DT', 2025, '4 tiempos OCH / Balanceador', '250 cc', '16 HP / 7500 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (42, 'Barras invertidas / Monoshock', 'Barras invertidas', '200 cm', '77 cm', '117 cm', '125 km/h');

-- R300
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (43, 'DUCONDA', 'R300', 2025, '4 tiempos OCH / Balanceador', '300 cc', '26 HP / 8500 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (43, 'Barras invertidas / Monoshock', 'Barras invertidas', '203 cm', '85.6 cm', '112.4 cm', '150 km/h');

-- DUCO 200DT
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (44, 'DUCONDA', 'DUCO 200DT', 2025, '4 tiempos OCH / Balanceador', '200 cc', '17 HP / 8500 r/min', 0.00, 'N/A', 'N/A', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, telescopic_forks, length, width, height, max_speed)
VALUES (44, 'Barras telescópicas / Monoshock', 'Barras telescópicas', '213 cm', '82 cm', '120 cm', '120 km/h');


-----------------
-----------------
-----JCH---------
-----------------
-----------------
-- KALLPA 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (45, 'JCH', 'KALLPA 150', 2025, 'OHC', '149.6 CC', '7.9 hp / 7000 rpm', 0.00, 'N/A', 'N/A', '', 'azul, negro, rojo, blanco, dorado', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (45, 'Disco / Disco', 'Telescópica / Doble Amortiguador', '130/60-13 // 130/60-13');

-- T-28 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (46, 'JCH', 'T-28 150', 2025, 'OHC', '149.6 CC', '8.98 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, rojo, azul, blanco, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (46, 'Disco / Disco', 'Telescópica / Doble Amortiguador', '120/70-12 // 120/70-12');

-- URBAN T-29 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (47, 'JCH', 'URBAN T-29 150', 2025, 'OHC', '149.6 CC', '8.71 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'azul, negro, rojo, blanco, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (47, 'Disco / Disco', 'Telescópica / Doble Amortiguador', '120/70-12 // 120/70-12');

-- STYLE 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (48, 'JCH', 'STYLE 150', 2025, 'OHC', '149.6 CC', '8.71 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'morado, negro, blanco, rojo', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (48, 'Disco / Tambor', 'Telescópica / Doble Amortiguador', '3.50-10 // 3.50-10');

-- VOLT 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (49, 'JCH', 'VOLT 150', 2025, 'OHC', '149.6 CC', '9.65 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, blanco, morado', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (49, 'Disco / Tambor', 'Telescópica / Doble Amortiguador', '3.50-10 // 3.50-10');

-- ONE 125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (50, 'JCH', 'ONE 125', 2025, 'OHC', '119.7 CC', '8.7 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'azul, rojo, verde, negro', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (50, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '2.50-17 // 2.75-17');

-- EAGLE 125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (51, 'JCH', 'EAGLE 125', 2025, 'OHC', '106.7 CC', '7.51 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, blanco, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (51, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '150/80-13 // 115/80-13');

-- ENERGY 110
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (52, 'JCH', 'ENERGY 110', 2025, 'OHC', '106.7 CC', '6.71 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, azul', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (52, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '110/90-13 // 110/90-13');

-- FALKON 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (53, 'JCH', 'FALKON 150', 2025, 'OHC', '149 CC', '12.3 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'azul, rojo, negro, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (53, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '2.75-18 // 3.25-18');

-- TARKI 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (54, 'JCH', 'TARKI 150', 2025, 'OHC', '149 CC', '12.3 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'azul, rojo, negro, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (54, 'Tambor / Tambor', 'Telescópica / Doble amortiguador', '2.75-18 // 3.00-18');

-- WORKMAN 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (55, 'JCH', 'WORKMAN 150', 2025, 'OHV', '149 CC', '12.3 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'verde, negro, azul, rojo', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (55, 'Disco / Tambor', 'Telescópica / Monoshock', '110/90-17 // 130/80-17');

-- TRAVEL 250 (OFF-ROAD)
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (56, 'JCH', 'TRAVEL 250 (OFF-ROAD)', 2025, 'OHC', '223 CC', '17.4 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (56, 'Disco / Disco', 'Barras invertidas / Monoshock', '4.60-17 // 5.10-17');

-- TRAVEL 250 (DOBLE PROPÓSITO)
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (57, 'JCH', 'TRAVEL 250 (DOBLE PROPÓSITO)', 2025, 'OHC', '223 CC', '17.4 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'negro, verde, marrón', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (57, 'Disco / Disco', 'Barras invertidas / Monoshock', '110/90-17 // 130/80-17');

-- ARIZONA 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (58, 'JCH', 'ARIZONA 250', 2025, 'OHC', '223 CC', '17.7 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, rojo, naranja, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (58, 'Disco / Tambor', 'Barras invertidas / Monoshock', '3.50-17 // 4.60-17');

-- CROSSMAX 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (59, 'JCH', 'CROSSMAX 250', 2025, 'OHC', '229.6 CC', '14 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'naranja, negro, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (59, 'Disco / Tambor', 'Barras invertidas / Monoshock', '3.50-17 // 4.60-17');

-- MRX 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (60, 'JCH', 'MRX 200', 2025, 'OHV', '196.98 CC', '13 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, rojo, azul', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (60, 'Disco / Tambor', 'Telescópica / Monoshock', '90/100-19 // 4.60-17');

-- TRACKER 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (61, 'JCH', 'TRACKER 200', 2025, 'OHV', '196.98 CC', '13 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'naranja, negro, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (61, 'Disco / Tambor', 'Barras invertidas / Monoshock', '110/90-17 // 130/80-17');

-- TITAN 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (62, 'JCH', 'TITAN 200', 2025, 'OHV', '197 CC', '13.67 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'azul, rojo, negro, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (62, 'Disco / Tambor', 'Telescópica / Monoshock', '100/90-19 // 4.60-17');

-- TORNADO 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (63, 'JCH', 'TORNADO 200', 2025, 'OHV', '196.98 CC', '13 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, blanco, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (63, 'Disco / Tambor', 'Telescópica / Monoshock', '80/100-18 // 120/80-18');

-- MONTANA 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (64, 'JCH', 'MONTANA 200', 2025, 'OHV', '197 CC', '14.08 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, azul, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (64, 'Disco / Tambor', 'Telescópica / Monoshock', '3.50-17 // 4.60-17');

-- MRX 200 PRO
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (65, 'JCH', 'MRX 200 PRO', 2025, 'OHV', '196.98 CC', '13 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, azul, verde', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (65, 'Disco / Tambor', 'Telescópica / Monoshock', '90/90-19 // 110/100-18');

-- GS 250 4V
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (66, 'JCH', 'GS 250 4V', 2025, 'OHC', '249.4 CC', '24.13 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'azul, gris, negro', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (66, 'Disco / Disco', 'Barras invertidas / Monoshock', '110/90-17 // 130/80-17');

-- INDIAN 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (67, 'JCH', 'INDIAN 250', 2025, 'OHV', '229.5 CC', '14.08 hp / 7000 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, blanco, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (67, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '110/90-16 // 130/90-15');

-- SPORT 300
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (68, 'JCH', 'SPORT 300', 2025, 'OHC', '271.3 CC', '21.4 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, rojo, verde, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (68, 'Disco doble / Disco', 'Barras invertidas / Monoshock', '110/70-17 // 150/70-17');

-- RACING 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (69, 'JCH', 'RACING 250', 2025, 'OHC', '249.6 CC', '15.42 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, naranja, azul, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (69, 'Disco doble / Disco', 'Barras invertidas / Monoshock', '110/70-17 // 150/70-17');

-- R6 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (70, 'JCH', 'R6 250', 2025, 'OHC', '249.9 CC', '18.77 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, azul, naranja', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (70, 'Disco / Disco', 'Telescópica / Monoshock', '110/70-17 // 150/70-17');

-- RZ88 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (71, 'JCH', 'RZ88 250', 2025, 'OHC', '249.9 CC', '18.77 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'blanco, azul, negro', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (71, 'Disco doble / Disco', 'Telescópica / Monoshock', '110/70-17 // 150/70-17');

-- SPORT 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (72, 'JCH', 'SPORT 200', 2025, 'OHC', '197 CC', '16 hp / 8000 rpm', 0.00, 'N/A', 'N/A', '', 'naranja, negro, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (72, 'Disco / Disco', 'Barras invertidas / Monoshock', '110/70-17 // 130/70-17');

-- KP MINI 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (73, 'JCH', 'KP MINI 150', 2025, 'OHC', '149 CC', '12.7 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'rojo, negro, azul, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (73, 'Disco / Disco', 'Barras invertidas / Monoshock', '120/70-12 // 130/70-12');

-- RAPID 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (74, 'JCH', 'RAPID 150', 2025, 'OHV', '149.6 CC', '12.34 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, amarillo, azul, rojo', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (74, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '2.75-18 // 3.00-18');

-- MAX 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (75, 'JCH', 'MAX 150', 2025, 'OHV', '149 CC', '11.8 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, rojo, azul, amarillo', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (75, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '110/70-17 // 130/70-17');

-- WORK 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (76, 'JCH', 'WORK 150', 2025, 'OHV', '149 CC', '12.3 hp / 8500 rpm', 0.00, 'N/A', 'N/A', '', 'negro, azul, rojo, blanco', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (76, 'Disco / Tambor', 'Telescópica / Doble amortiguador', '2.75-18 // 3.00-18');

-- MT 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (77, 'JCH', 'MT 200', 2025, 'OHC', '196.8 CC', '13.6 hp / 7500 rpm', 0.00, 'N/A', 'N/A', '', 'azul, negro, rojo', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes, suspension, tires)
VALUES (77, 'Disco / Disco', 'Barras invertidas / Monoshock', '100/80-17 // 130/70-17');



---------------------
---------------------
-------REZZIO--------
---------------------
---------------------

-- Athorm 200 6G
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (78, 'REZZIO', 'Athorm 200 6G', 2025, 'N/A', '200 CC', '18 HP/8000 RPM', 0.00, 'Ciudad', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (78, 'Disco/Tambor');

-- Velox 200 6G
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (79, 'REZZIO', 'Velox 200 6G', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Ciudad', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (79, 'Disco/Tambor');

-- Maxos 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (80, 'REZZIO', 'Maxos 150', 2025, 'N/A', '150 CC', '12.7 HP/9000 RPM', 0.00, 'Ciudad', '4 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (80, 'Disco/Tambor');

-- Confort 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (81, 'REZZIO', 'Confort 150', 2025, 'N/A', '150 CC', '12 HP/7000 RPM', 0.00, 'Scooter', 'Automático', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (81, 'Disco/Disco');

-- Pluss 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (82, 'REZZIO', 'Pluss 150', 2025, 'N/A', '150 CC', '12 HP/7000 RPM', 0.00, 'Scooter', 'Automático', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (82, 'Disco/Disco');

-- Lite 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (83, 'REZZIO', 'Lite 150', 2025, 'N/A', '150 CC', '12 HP/7000 RPM', 0.00, 'Scooter', 'Automático', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (83, 'Disco/Disco');

-- Rocket 125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (84, 'REZZIO', 'Rocket 125', 2025, 'N/A', '125 CC', '8.3 HP/7000 RPM', 0.00, 'Scooter', '4 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (84, 'Disco/Tambor');

-- Spark 125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (85, 'REZZIO', 'Spark 125', 2025, 'N/A', '125 CC', '8.3 HP/7000 RPM', 0.00, 'Scooter', '4 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (85, 'Disco/Tambor');

-- Waze 125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (86, 'REZZIO', 'Waze 125', 2025, 'N/A', '150 CC', '12 HP/7000 RPM', 0.00, 'Scooter', 'Automático', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (86, 'Disco/Tambor');

-- Power 200 6G
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (87, 'REZZIO', 'Power 200 6G', 2025, 'N/A', '200 CC', '16 HP/7000 RPM', 0.00, 'Utilitarias', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (87, 'Disco/Tambor');

-- Power 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (88, 'REZZIO', 'Power 200', 2025, 'N/A', '200 CC', '16 HP/7000 RPM', 0.00, 'Utilitarias', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (88, 'Disco/Tambor');

-- Power 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (89, 'REZZIO', 'Power 150', 2025, 'N/A', '150 CC', '12 HP/7000 RPM', 0.00, 'Utilitarias', '4 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (89, 'Disco/Tambor');

-- Kratos Pro 4.0
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (90, 'REZZIO', 'Kratos Pro 4.0', 2025, 'N/A', '367 CC', '23 HP/8000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Control', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (90, 'Doble Disco/Disco');

-- Predator Pro 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (91, 'REZZIO', 'Predator Pro 250', 2025, 'N/A', '250 CC', '21 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (91, 'Disco/Disco');

-- Z-Max 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (92, 'REZZIO', 'Z-Max 250', 2025, 'N/A', '250 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (92, 'Disco/Disco');

-- Honor 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (93, 'REZZIO', 'Honor 250', 2025, 'N/A', '250 CC', '16 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (93, 'Disco/Disco');

-- Kratos 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (94, 'REZZIO', 'Kratos 250', 2025, 'N/A', '250 CC', '18 HP/7500 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (94, 'Disco/Disco');

-- Predator 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (95, 'REZZIO', 'Predator 250', 2025, 'N/A', '250 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (95, 'Disco/Disco');

-- Voltrex 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (96, 'REZZIO', 'Voltrex 250', 2025, 'N/A', '250 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (96, 'Disco/Disco');

-- XPlotion 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (97, 'REZZIO', 'XPlotion 250', 2025, 'N/A', '250 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (97, 'Disco/Disco');

-- Aventus 2.0
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (98, 'REZZIO', 'Aventus 2.0', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (98, 'Disco/Disco');

-- Rextor 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (99, 'REZZIO', 'Rextor 200', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (99, 'Disco/Disco');

-- Lithium 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (100, 'REZZIO', 'Lithium 200', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Premium', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (100, 'Disco/Disco');

-- KTR 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (101, 'REZZIO', 'KTR 250', 2025, 'N/A', '250 CC', '18 HP/8000 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (101, 'Disco/Tambor');

-- ZRF 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (102, 'REZZIO', 'ZRF 250', 2025, 'N/A', '250 CC', '18 HP/7500 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (102, 'Disco/Tambor');

-- Primex 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (103, 'REZZIO', 'Primex 250', 2025, 'N/A', '250 CC', '18 HP/7000 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (103, 'Disco/Tambor');

-- FMX 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (104, 'REZZIO', 'FMX 200', 2025, 'N/A', '200 CC', '18 HP/8000 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (104, 'Disco/Tambor');

-- X-Pro 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (105, 'REZZIO', 'X-Pro 200', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico/Pedal', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (105, 'Disco/Disco');

-- XTrail 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (106, 'REZZIO', 'XTrail 200', 2025, 'N/A', '200 CC', '18 HP/7000 RPM', 0.00, 'Todoterreno', '6 velocidades', '', 'N/A', 'Arranque Eléctrico', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, brakes)
VALUES (106, 'Disco/Disco');



------------------------
------------------------
--------SONLINK---------
------------------------
------------------------
-- SL150/200-F1
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (107, 'SONLINK', 'SL150/200-F1', 2025, 'TGF(OHV)', '150/200 CC', '13/8500 - 13.6/8000', 0.00, 'Pistero', '5/6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (107, 'Barras invertidas / Monoshock', '11.5/7500 - 14.2/6000', 'Disco/Disco', '14.5L', '90/90-17 120/80-17');

-- SL200-GF/GFA
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (108, 'SONLINK', 'SL200-GF/GFA', 2025, 'TGF(OHV) / CBF(OHC)', '200 CC', '15/8000', 0.00, 'Pistero', '5/6 velocidades - 5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (108, 'Barras invertidas/Monoshock', '15/5000', 'Disco/Disco', '15L', '100/70-17 150/70-17');

-- SL200-F7
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (109, 'SONLINK', 'SL200-F7', 2025, 'TGF(OHV)', '200 CC', '16/8000', 0.00, 'Pistero', '5/6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (109, 'Barras invertidas/Monoshock', '15/5000', 'Disco/Disco', '21L', '100/80-17 130/70-17');

-- SL200-F8
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (110, 'SONLINK', 'SL200-F8', 2025, 'TGF(OHV)', '200 CC', '15/8000', 0.00, 'Pistero', '5/6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (110, 'Barras invertidas/Monoshock', '15/5000', 'Disco/Disco', '15L', '90/90-17 120/80-17');

-- SL200-F8A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (111, 'SONLINK', 'SL200-F8A', 2025, 'TGF(OHV)', '200 CC', '15/8000', 0.00, 'Pistero', '5/6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (111, 'Barras invertidas/Monoshock', '15/5000', 'Disco/Disco', '15L', '90/90-17 120/80-17');

-- SL200-F9/F9A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (112, 'SONLINK', 'SL200-F9/F9A', 2025, 'TGF(OHV) / CBF(OHC)', '200 CC', '15/8000', 0.00, 'Pistero', '5/6 velocidades - 5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (112, 'Telescópica/Monoshock', '15/8000', 'Disco/Disco', '14L', '100/70-17 130/70-17');

-- SL200-K11
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (113, 'SONLINK', 'SL200-K11', 2025, 'N/A', '200 CC', '13.5/8500', 0.00, 'Paseo', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (113, 'Telescópica/Brazos Oscilantes', '11.8/6500', 'Tambor/Tambor', '15.5L', '3.25-18 3.25-18');

-- SL150-KG
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (114, 'SONLINK', 'SL150-KG', 2025, 'N/A', '150 CC', '6.2/7500', 0.00, 'Paseo', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (114, 'Telescópica/Brazos Oscilantes', '8.5/6500', 'Disco/Tambor', '5.5L', 'Disco/Tambor');

-- SL105
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (115, 'SONLINK', 'SL105', 2025, 'N/A', '105 CC', '7.5/8500', 0.00, 'Paseo', '4 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (115, 'Telescópica/Brazos Oscilantes', '6.5/6500', 'Disco/Disco', '9.1L', '2.50-17 2.75-17');

-- SL125T-2A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (116, 'SONLINK', 'SL125T-2A', 2025, 'N/A', '125 CC', '6.2/7500', 0.00, 'Paseo', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (116, 'Telescópica/Brazos Oscilantes', '8.5/6500', 'Disco/Tambor', '5.5L', 'Disco/Tambor');

-- SL150T-5
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (117, 'SONLINK', 'SL150T-5', 2025, 'N/A', '150 CC', '8.5/6500', 0.00, 'Paseo', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (117, 'Telescópica/Brazos Oscilantes', '8.5/6500', 'Disco/Tambor', '5.5L', '120/70-12 120/70-12');

-- SL150T-6
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (118, 'SONLINK', 'SL150T-6', 2025, 'N/A', '150 CC', '8.5/6500', 0.00, 'Paseo', 'CVT', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (118, 'Telescópica/Brazos Oscilantes', '8.5/6500', 'Disco/Tambor', '5.5L', '120/70-12 120/70-12');

-- SL200G-3
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (119, 'SONLINK', 'SL200G-3', 2025, 'N/A', '200 CC', '15/8000', 0.00, 'Todo Terreno', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (119, 'Telescópica/Monoshock', '15/8000', 'Disco/Disco', '16L', '2.50-17 4.60-17');

-- SL200G-LI
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (120, 'SONLINK', 'SL200G-LI', 2025, 'N/A', '200 CC', '15/8000', 0.00, 'Todo Terreno', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (120, 'Telescópica/Monoshock', '15/8000', 'Disco/Disco', '15L', '2.50-17 4.60-17');

-- SL200-3F
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (121, 'SONLINK', 'SL200-3F', 2025, 'N/A', '200 CC', '15/8000', 0.00, 'Ciudad', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (121, 'Telescópica/Brazos Oscilantes', '14.5/5000', 'Disco/Tambor', '14L', '2.75-18 90/90-18');

-- SL150-HB
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (122, 'SONLINK', 'SL150-HB', 2025, 'N/A', '150 CC', '12.5/8500', 0.00, 'Ciudad', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (122, 'Telescópica/Brazos Oscilantes', '11.5/7000', 'Disco/Tambor', '16L', '2.75-18 3.00-18');

-- SL150-17A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (123, 'SONLINK', 'SL150-17A', 2025, 'N/A', '150 CC', '12/8500', 0.00, 'Ciudad', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (123, 'Telescópica/Brazos Oscilantes', '11/7000', 'Disco/Tambor', '16.5L', '2.75-18 3.00-18');

-- SL150/200-A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (124, 'SONLINK', 'SL150/200-A', 2025, 'N/A', '150/200 CC', '12.6/8500', 0.00, 'Moto Taxi', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (124, 'Telescópica/Brazos Oscilantes', '15/8000', 'Tambor/Tambor', '14L', '2.75-18 3.25-17');

----------------------
----------------------
-----WANXIN-----------
----------------------
----------------------

-- MOTOCICLETAS WANXIN - INSERCIONES POSTGRESQL

-- PARLOUR 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (125, 'WANXIN', 'PARLOUR 200', 2025, '4T-OHC', '200 CC', '18.5/8500', 0.00, 'Sport', '6 velocidades', '', 'Azul', 'Modelo deportivo con motor 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (125, 'N/A', '18.2/7500', 'Disco/Disco', '16L', '120/70-17 180/55-17');

-- K01200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (126, 'WANXIN', 'K01200', 2025, '4T-OHC', '200 CC', '18.5/8500', 0.00, 'Adventure', '6 velocidades', '', 'Azul', 'Modelo Adventure/Enduro con motor 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (126, 'N/A', '18.2/7500', 'Disco/Disco', '16L', '90/90-21 120/80-18');

-- MS200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (127, 'WANXIN', 'MS200', 2025, '4T-OHC', '200 CC', '18.5/8500', 0.00, 'Sport', '6 velocidades', '', 'Negro/Verde', 'Modelo deportivo con motor 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (127, 'N/A', '18.2/7500', 'Disco/Disco', '16L', '110/70-17 150/60-17');

-- ROADBLOCK 250 II
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (128, 'WANXIN', 'ROADBLOCK 250 II', 2025, '4T-OHC', '250 CC', '20/8000', 0.00, 'Sport', '6 velocidades', '', 'Azul', 'Modelo pistera 250cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (128, 'N/A', '22/6500', 'Disco/Disco', '15L', '120/70-17 180/55-17');

-- TOK-125
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (129, 'WANXIN', 'TOK-125', 2025, '4T-OHC', '125 CC', '9.5/8000', 0.00, 'Sport', '6 velocidades', '', 'Rojo', 'Modelo pistera 125cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (129, 'N/A', '10.2/6500', 'Disco/Disco', '12L', '100/80-17 130/70-17');

-- ENERGY 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (130, 'WANXIN', 'ENERGY 200', 2025, '4T-OHC', '200 CC', '16/8500', 0.00, 'Sport', '6 velocidades', '', 'Amarillo', 'Modelo pistera 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (130, 'N/A', '16.5/7000', 'Disco/Disco', '14L', '110/70-17 150/60-17');

-- PS200N
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (131, 'WANXIN', 'PS200N', 2025, '4T-OHC', '200 CC', '16/8500', 0.00, 'Sport', '6 velocidades', '', 'Negro/Naranja', 'Modelo pistera 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (131, 'N/A', '16.5/7000', 'Disco/Disco', '14L', '110/70-17 150/60-17');

-- AMARU 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (132, 'WANXIN', 'AMARU 200', 2025, '4T-OHC', '200 CC', '16/8000', 0.00, 'Todo Terreno', '5 velocidades', '', 'Negro/Verde', 'Modelo todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (132, 'N/A', '17/6500', 'Disco/Disco', '12L', '3.00-21 4.60-18');

-- WX150G-P2
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (133, 'WANXIN', 'WX150G-P2', 2025, '4T-OHC', '150 CC', '11/8000', 0.00, 'Todo Terreno', '5 velocidades', '', 'Negro', 'Modelo todo terreno 150cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (133, 'N/A', '12/6500', 'Disco/Disco', '10L', '3.00-18 4.10-18');

-- CROSS 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (134, 'WANXIN', 'CROSS 200', 2025, '4T-OHC', '200 CC', '15/7500', 0.00, 'Todo Terreno', '5 velocidades', '', 'Gris', 'Modelo cross todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (134, 'N/A', '16.8/6000', 'Disco/Disco', '11L', '80/100-21 110/90-18');

-- TT200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (135, 'WANXIN', 'TT200', 2025, '4T-OHC', '200 CC', '15/7500', 0.00, 'Todo Terreno', '5 velocidades', '', 'Rojo/Negro', 'Modelo todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (135, 'N/A', '16.8/6000', 'Disco/Disco', '11L', '80/100-21 110/90-18');

-- 100G-7
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (136, 'WANXIN', '100G-7', 2025, '4T-OHC', '100 CC', '7.5/8000', 0.00, 'Todo Terreno', '4 velocidades', '', 'Rojo', 'Modelo todo terreno 100cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (136, 'N/A', '8.2/6500', 'Tambor/Tambor', '8L', '2.75-21 4.10-18');

-- WX200G-8S
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (137, 'WANXIN', 'WX200G-8S', 2025, '4T-OHC', '200 CC', '15/7500', 0.00, 'Todo Terreno', '5 velocidades', '', 'Negro', 'Modelo todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (137, 'N/A', '16.8/6000', 'Disco/Disco', '11L', '80/100-21 110/90-18');

-- WX200G-8E
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (138, 'WANXIN', 'WX200G-8E', 2025, '4T-OHC', '200 CC', '15/7500', 0.00, 'Todo Terreno', '5 velocidades', '', 'Rojo', 'Modelo todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (138, 'N/A', '16.8/6000', 'Disco/Disco', '11L', '80/100-21 110/90-18');

-- WX200G-4GE
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (139, 'WANXIN', 'WX200G-4GE', 2025, '4T-OHC', '200 CC', '15/7500', 0.00, 'Todo Terreno', '5 velocidades', '', 'Negro', 'Modelo todo terreno 200cc', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (139, 'N/A', '16.8/6000', 'Disco/Disco', '11L', '80/100-21 110/90-18');

-- WK125-17
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (140, 'WANXIN', 'WK125-17', 2025, '4T OHC', '125 CC', '10.8/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 125cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (140, 'N/A', '10.8/6000', 'N/A', '14L', 'N/A');

-- SKYWALKER 250
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (141, 'WANXIN', 'SKYWALKER 250', 2025, '4T OHC', '250 CC', '17/8000', 0.00, 'Standard', '5 velocidades', '', 'Blue', 'Motocicleta 250cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (141, 'N/A', '20/6000', 'N/A', '18L', 'N/A');

-- WK110-6A
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (142, 'WANXIN', 'WK110-6A', 2025, '4T OHC', '110 CC', '7.5/8000', 0.00, 'Standard', '4 velocidades', '', 'Red', 'Motocicleta 110cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (142, 'N/A', '7.8/6000', 'N/A', '4.2L', 'N/A');

-- WK150-CB
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (143, 'WANXIN', 'WK150-CB', 2025, '4T OHC', '150 CC', '11/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 150cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (143, 'N/A', '12/6000', 'N/A', '12L', 'N/A');

-- COBRA 200 GT
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (144, 'WANXIN', 'COBRA 200 GT', 2025, '4T OHC', '200 CC', '15.5/8000', 0.00, 'Standard', '5 velocidades', '', 'Orange', 'Motocicleta 200cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (144, 'N/A', '16.8/6000', 'N/A', '16L', 'N/A');

-- WK200-8M
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (145, 'WANXIN', 'WK200-8M', 2025, '4T OHC', '200 CC', '15.5/8000', 0.00, 'Standard', '5 velocidades', '', 'Black', 'Motocicleta 200cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (145, 'N/A', '16.8/6000', 'N/A', '16L', 'N/A');

-- REBEL 200
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (146, 'WANXIN', 'REBEL 200', 2025, '4T OHC', '200 CC', '15.5/8000', 0.00, 'Standard', '5 velocidades', '', 'Black', 'Motocicleta 200cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (146, 'N/A', '16.8/6000', 'N/A', '16L', 'N/A');

-- ASH 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (147, 'WANXIN', 'ASH 150', 2025, '4T OHC', '150 CC', '11/8000', 0.00, 'Standard', '5 velocidades', '', 'Green', 'Motocicleta 150cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (147, 'N/A', '12/6000', 'N/A', '12L', 'N/A');

-- WK125-LT
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (148, 'WANXIN', 'WK125-LT', 2025, '4T OHC', '125 CC', '10.8/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 125cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (148, 'N/A', '10.8/6000', 'N/A', '14L', 'N/A');

-- WK110-18
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (149, 'WANXIN', 'WK110-18', 2025, '4T OHC', '110 CC', '7.5/8000', 0.00, 'Standard', '4 velocidades', '', 'Red', 'Motocicleta 110cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (149, 'N/A', '7.8/6000', 'N/A', '4.2L', 'N/A');

-- WK125L-2
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (150, 'WANXIN', 'WK125L-2', 2025, '4T OHC', '125 CC', '10.8/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 125cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (150, 'N/A', '10.8/6000', 'N/A', '14L', 'N/A');

-- WK200-G5
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (151, 'WANXIN', 'WK200-G5', 2025, '4T OHC', '200 CC', '15.5/8000', 0.00, 'Standard', '5 velocidades', '', 'Yellow', 'Motocicleta 200cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (151, 'N/A', '16.8/6000', 'N/A', '16L', 'N/A');

-- ATLW 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (152, 'WANXIN', 'ATLW 150', 2025, '4T OHC', '150 CC', '11/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 150cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (152, 'N/A', '12/6000', 'N/A', '12L', 'N/A');

-- COBRA 150
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (153, 'WANXIN', 'COBRA 150', 2025, '4T OHC', '150 CC', '11/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 150cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (153, 'N/A', '12/6000', 'N/A', '12L', 'N/A');

-- WK200-G2
INSERT INTO motorcycles (id, brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES (154, 'WANXIN', 'WK200-G2', 2025, '4T OHC', '200 CC', '15.5/8000', 0.00, 'Standard', '5 velocidades', '', 'Red', 'Motocicleta 200cc con ignición CDI', TRUE);
INSERT INTO motorcycle_specs (motorcycle_id, suspension, max_torque, brakes, fuel_capacity, tires)
VALUES (154, 'N/A', '16.8/6000', 'N/A', '16L', 'N/A');



------------------------
------------------------
-------B52--------------
------------------------
------------------------
-- MODELO B52-107CC (PREVENTA)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'B52-107CC', 2025, '4T OHC', '106.7cc', '6.5 HP / 8000 RPM', 0, 'N/A', '4 velocidades', '', 'N/A', 'PREVENTA', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'B52-107CC' LIMIT 1), 'Horquillas telescópicas / Doble amortiguador', 'Tambor / Tambor', '3.5 litros', '85 KM/H', '2.50-17 / 2.75-17', 'Analógico');

-- MODELO SCOOTER 125CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'SCOOTER 125CC', 2025, '4T OHC', '125cc', '8.04 HP / 7000 RPM', 0, 'Scooter', 'Automática', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'SCOOTER 125CC' LIMIT 1), 'Hidráulica / Hidráulica', 'Disco / Tambor', '2.6 litros', '80 KM/H', '3.50-10 / 3.50-10', 'N/A');

-- MODELO DEPORTIVO 180CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'DEPORTIVO 180CC', 2025, '4T OHC a cadenilla', '180cc', '14.48 HP', 0, 'Deportiva', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'DEPORTIVO 180CC' LIMIT 1), 'Horquillas telescópicas / Doble amortiguador', 'Disco ventilado doble pistón / Tambor mecánico', '2.83 galones', '115 KM/H', '90-90-17 / 110-80-17', 'Digital');

-- MODELO DEPORTIVO 200CC (PREVENTA)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'DEPORTIVO 200CC', 2025, '4T OHC a cadenilla', '200cc', '16 HP', 0, 'Deportiva', '6 velocidades', '', 'Negro brillante, negro mate', 'PREVENTA', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'DEPORTIVO 200CC' LIMIT 1), 'Horquillas telescópicas / Monoshock', 'Disco ventilado doble pistón / Disco ventilado un pistón', '3.3 galones', '115 KM/H', '100-90-17 / 130-80-17', 'Digital');

-- MODELO DEPORTIVO 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'DEPORTIVO 250CC', 2025, '4T OHC a cadenilla', '250cc', '17 HP', 0, 'Deportiva', '6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'DEPORTIVO 250CC' LIMIT 1), 'Horquillas telescópicas invertidas / Monoshock', 'Disco ventilado doble pistón / Disco ventilado un pistón', '3.69 galones', '130 KM/H', '110-90-17 / 130-80-17', 'Analógico-digital');

-- MODELO ENDURO/CROSS 200CC - VERSIÓN 1 (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'ENDURO/CROSS 200CC V1', 2025, '4T OHV con balanceador', '200cc', '16 HP', 0, 'Enduro/Cross', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'ENDURO/CROSS 200CC V1' LIMIT 1), 'Horquillas telescópicas / Monoshock', 'Disco ventilado un pistón / Tambor mecánico', '3.17 galones', '110 KM/H', '19" / 17"', 'Digital');

-- MODELO ENDURO/CROSS 200CC - VERSIÓN 2 (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'ENDURO/CROSS 200CC V2', 2025, '4T OHV con balanceador', '200cc', '16 HP', 0, 'Enduro/Cross', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'ENDURO/CROSS 200CC V2' LIMIT 1), 'Horquillas telescópicas / Monoshock', 'Disco ventilado un pistón / Tambor mecánico', '3.17 galones', '110 KM/H', '110-100-17 / 120-100-17', 'Digital');

-- MODELO ENDURO/CROSS 145CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'ENDURO/CROSS 145CC', 2025, '4T OHC', '144.6cc', '11.58 HP / 8500 RPM', 0, 'Enduro/Cross', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'ENDURO/CROSS 145CC' LIMIT 1), 'Monotubo ajustable / Monocilíndrico hidráulico', 'Disco / Disco', '9.10 litros', '90 KM/H', '80-100-21 / 100-100-18', 'Digital');

-- MODELO ENDURO/CROSS 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'ENDURO/CROSS 250CC', 2025, '4T OHC', '250cc', '18.77 HP / 8000 RPM', 0, 'Enduro/Cross', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'ENDURO/CROSS 250CC' LIMIT 1), 'Barras invertidas / Monoshock', 'Disco ventilado / Disco ventilado', '7.8 litros', 'N/A', '80-100-21 / 100-100-18', 'Digital');

-- MODELO CRUISER 200CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'CRUISER 200CC', 2025, '4T OHC a cadenilla', '200cc', '16 HP', 0, 'Cruiser', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'CRUISER 200CC' LIMIT 1), 'Horquillas telescópicas / Doble amortiguador', 'Disco ventilado doble pistón / Tambor mecánico', '4.5 galones', '110 KM/H', '110-90-16 / 130-90-15', 'Digital');

-- MODELO SCOOTER 250CC (VERSIÓN 2025)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'SCOOTER 250CC', 2025, '4T SOHC Euro III', '250cc', '16.8 HP', 0, 'Scooter', '6 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'SCOOTER 250CC' LIMIT 1), 'Horquillas telescópicas / Doble amortiguador', 'Disco ventilado triple pistón / Disco ventilado CBS doble pistón', '2.5 galones', '120 KM/H', '100-90-16 / 130-90-15', 'N/A');

-- MODELO NAKED/STREET 250CC (VERSIÓN 2024)
INSERT INTO motorcycles (brand, model, year, engine, displacement, power, price_soles, style, transmission, image_url, color, description, is_active)
VALUES ('B52', 'NAKED/STREET 250CC', 2024, '4T OHV', '250cc', '18 HP', 0, 'Naked/Street', '5 velocidades', '', 'N/A', 'N/A', TRUE);

INSERT INTO motorcycle_specs (motorcycle_id, suspension, brakes, fuel_capacity, max_speed, tires, dashboard)
VALUES ((SELECT id FROM motorcycles WHERE brand = 'B52' AND model = 'NAKED/STREET 250CC' LIMIT 1), 'Horquillas telescópicas / Monoshock', 'Disco ventilado doble pistón / Disco ventilado doble pistón', '3.5 galones', '130 KM/H', '110-80-17 / 140-70-17', 'Digital');
