-- Verify load_brasil_osm:view_big_areas on pg

BEGIN;
    SELECT * FROM osm_brasil.biggest_areas LIMIT 1;
    SELECT * FROM osm_brasil.ways_count LIMIT 1;
ROLLBACK;
