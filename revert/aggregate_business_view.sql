-- Revert load_brasil_osm:aggregate_business_view from pg

BEGIN;

    DROP VIEW osm_brasil.business_points_geojson;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
