-- Verify load_brasil_osm:aggregate_business_view on pg

BEGIN;

    SELECT json FROM osm_brasil.business_points_geojson LIMIT 1;

ROLLBACK;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
