-- Revert load_brasil_osm:view_big_areas from pg

BEGIN;

    DROP VIEW osm_brasil.biggest_areas;
    DROP VIEW osm_brasil.ways_count;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
