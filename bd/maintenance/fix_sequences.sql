-- Ajusta las secuencias a los valores máximos actuales.
-- Útil después de cargas manuales o importaciones.

SELECT setval('brand_info_id_seq', COALESCE((SELECT MAX(id) FROM brand_info),1));
SELECT setval('motorcycles_id_seq', COALESCE((SELECT MAX(id) FROM motorcycles),1));
SELECT setval('motorcycle_specs_id_seq', COALESCE((SELECT MAX(id) FROM motorcycle_specs),1));

-- Verificación rápida (opcional)
-- SELECT 'brand_info', last_value FROM brand_info_id_seq;
-- SELECT 'motorcycles', last_value FROM motorcycles_id_seq;
-- SELECT 'motorcycle_specs', last_value FROM motorcycle_specs_id_seq;