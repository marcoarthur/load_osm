-- Verify load_brasil_osm:pgtap on pg

BEGIN;

	SELECT 1 / count(*) FROM pg_extension WHERE extname = 'pgtap';

ROLLBACK;
