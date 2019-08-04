-- Verify load_brasil_osm:appschema on pg

BEGIN;

	SELECT 1/COUNT(*) FROM information_schema.schemata WHERE schema_name = 'osm_brasil';

ROLLBACK;
