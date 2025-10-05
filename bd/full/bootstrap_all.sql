-- Orquestador de carga completa
-- Uso: psql -U <user> -d <database> -f bd/full/bootstrap_all.sql
-- Asume que estás en la raíz del repo o ajusta rutas relativas según necesidad.

\echo '== Iniciando bootstrap esquema =='
\i /bd/schema/01_schema.sql

\echo '== Seed mínimo =='
\i /bd/seeds/02_seed_min.sql

\echo '== Catálogo ULTRAVIP =='
\i /bd/catalog/03_ultravip.sql

\echo '== Catálogo DUCONDA =='
\i /bd/catalog/04_duconda.sql

\echo '== Catálogo JCH =='
\i /bd/catalog/05_jch.sql

\echo '== Catálogo REZZIO =='
\i /bd/catalog/06_rezzio.sql

\echo '== Catálogo ADVANCE =='
\i /bd/catalog/07_advance.sql

\echo '== Catálogo SONLINK =='
\i /bd/catalog/08_sonlink.sql

\echo '== Catálogo WANXIN =='
\i /bd/catalog/09_wanxin.sql

\echo '== Catálogo B52 =='
\i /bd/catalog/10_b52.sql

\echo '== Ajuste de secuencias (final) =='
\i /bd/maintenance/fix_sequences.sql

\echo '== Bootstrap completo =='