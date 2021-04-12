-- Verify load_brasil_osm:geometry_and_pk_oaddr on pg

BEGIN;

    SELECT geom FROM osm_brasil.oaddr LIMIT 1;

ROLLBACK;
-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
