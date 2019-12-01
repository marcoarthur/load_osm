-- Revert load_brasil_osm:appschema from pg

BEGIN;

	DROP SCHEMA osm_brasil CASCADE;

COMMIT;
