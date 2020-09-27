-- Revert load_brasil_osm:join_street_segments from pg

BEGIN;

    DROP FUNCTION osm_brasil.crossed_by( BIGINT );
    DROP TYPE osm_brasil.t_crossed_st;
    DROP VIEW osm_brasil.crossing_streets;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
