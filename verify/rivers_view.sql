-- Verify load_brasil_osm:rivers_view on pg

BEGIN;

    SELECT * from osm_brasil.rivers LIMIT 1;

ROLLBACK;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
