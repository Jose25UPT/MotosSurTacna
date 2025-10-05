-- Orquestador de carga completa
-- Uso: psql -U <user> -d <database> -f bd/full/bootstrap_all.sql
-- Asume que estás en la raíz del repo o ajusta rutas relativas según necesidad.

\echo '== Iniciando bootstrap esquema =='
\i ../schema/01_schema.sql

\echo '== Seed mínimo =='
\i ../seeds/02_seed_min.sql

\echo '== Catálogo ULTRAVIP =='
\i ../catalog/03_ultravip.sql

\echo '== Catálogo DUCONDA =='
\i ../catalog/04_duconda.sql

\echo '== Catálogo JCH =='
\i ../catalog/05_jch.sql

\echo '== Catálogo REZZIO =='
\i ../catalog/06_rezzio.sql

\echo '== Catálogo ADVANCE =='
\i ../catalog/07_advance.sql

\echo '== Catálogo SONLINK =='
\i ../catalog/08_sonlink.sql

\echo '== Catálogo WANXIN =='
\i ../catalog/09_wanxin.sql

\echo '== Catálogo B52 =='
\i ../catalog/10_b52.sql

\echo '== Ajuste de secuencias (final) =='
\i ../maintenance/fix_sequences.sql

\echo '== Bootstrap completo =='