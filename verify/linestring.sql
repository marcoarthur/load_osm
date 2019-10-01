-- Verify load_brasil_osm:linestring on pg

BEGIN;

SET search_path TO osm_brasil,public,topology;

SELECT linestring FROM ways LIMIT 1;

ROLLBACK;
