-- Revert load_brasil_osm:linestring from pg

BEGIN;

SET search_path TO osm_brasil,public,topology;

ALTER TABLE ways
DROP COLUMN linestring CASCADE;


COMMIT;
