-- Verify load_brasil_osm:openaddress on pg

BEGIN;

    SELECT * FROM osm_brasil.oaddr LIMIT 10;

ROLLBACK;
