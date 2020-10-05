-- Verify load_brasil_osm:economy_view on pg

BEGIN;

    SELECT * FROM osm_brasil.business LIMIT 1;
    SELECT * FROM osm_brasil.summary_business LIMIT 1;

ROLLBACK;
