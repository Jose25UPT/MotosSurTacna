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
