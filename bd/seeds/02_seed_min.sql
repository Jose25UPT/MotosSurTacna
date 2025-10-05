-- Seed mínimo inicial
-- Ejecutar después de schema/01_schema.sql
-- Contiene solo datos base imprescindibles. Evita insertar catálogos grandes.

-- Ejemplo de información de marca (extiende según necesidades)
INSERT INTO brand_info (brand, about)
VALUES ('ULTRAVIP', 'Marca enfocada en rendimiento y aventura')
ON CONFLICT (brand) DO NOTHING;

INSERT INTO brand_info (brand, about)
VALUES ('DUCONDA', 'Diseño urbano y utilitario')
ON CONFLICT (brand) DO NOTHING;

INSERT INTO brand_info (brand, about)
VALUES ('JCH', 'Variedad de modelos para distintos usos')
ON CONFLICT (brand) DO NOTHING;

INSERT INTO brand_info (brand, about)
VALUES ('REZZIO', 'Innovación y movilidad práctica')
ON CONFLICT (brand) DO NOTHING;

INSERT INTO brand_info (brand, about)
VALUES ('ADVANCE', 'Marca enfocada en modelos enduro y scooters para el mercado local')
ON CONFLICT (brand) DO NOTHING;

-- Puedes agregar aquí otra data mínima (parámetros globales, etc.)

SELECT setval('brand_info_id_seq', (SELECT MAX(id) FROM brand_info));