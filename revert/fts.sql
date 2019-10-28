-- Revert load_brasil_osm:fts from pg

BEGIN;

	ALTER TABLE ways DROP COLUMN ways_fts CASCADE;

COMMIT;
