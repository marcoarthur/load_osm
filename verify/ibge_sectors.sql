-- Verify load_brasil_osm:ibge_sectors on pg

BEGIN;

    SELECT * FROM osm_brasil.ibge_sectors LIMIT 1;

ROLLBACK;
