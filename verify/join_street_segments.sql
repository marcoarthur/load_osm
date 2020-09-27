-- Verify load_brasil_osm:join_street_segments on pg

BEGIN;

    SELECT * FROM osm_brasil.crossing_streets LIMIT 1;

ROLLBACK;
