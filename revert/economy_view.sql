-- Revert load_brasil_osm:economy_view from pg

BEGIN;

    DROP FUNCTION osm_brasil.summary_business_by_area( area geometry(Geometry,4326) );
    DROP VIEW osm_brasil.summary_business;
    DROP VIEW osm_brasil.business;

COMMIT;
-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
