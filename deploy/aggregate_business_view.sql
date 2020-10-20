-- Deploy load_brasil_osm:aggregate_business_view to pg

BEGIN;

    CREATE OR REPLACE VIEW osm_brasil.business_points_geojson AS
    WITH businesses AS (
        SELECT b.type, st_union(b.geom) as geom, count(*) as total
        FROM osm_brasil.business b
        GROUP BY type
        ORDER BY total
    ) SELECT fun_schema.rowjsonb_to_geojson(to_jsonb(bs.*)) as json
    FROM businesses bs;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
