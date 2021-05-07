-- Verify load_brasil_osm:school_views on pg

BEGIN;

    SELECT * FROM osm_brasil.schools LIMIT 1;

ROLLBACK;
