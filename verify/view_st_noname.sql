-- Verify load_brasil_osm:view_st_noname on pg

BEGIN;

    SELECT * FROM osm_brasil.streets_without_name LIMIT 1;

ROLLBACK;
