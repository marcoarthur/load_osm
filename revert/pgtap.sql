-- Revert load_brasil_osm:pgtap from pg

BEGIN;

DROP EXTENSION IF EXISTS pgtap;

COMMIT;
