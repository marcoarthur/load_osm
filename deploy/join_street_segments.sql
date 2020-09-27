-- Deploy load_brasil_osm:join_street_segments to pg

BEGIN;

    /*
    * osm_brasil.crossing_streets:
    *
    * relates all streets that cross each other.
    * 
    */

    CREATE OR REPLACE VIEW osm_brasil.crossing_streets AS
    WITH crossing_streets AS (
        WITH streets AS (
            SELECT *
            FROM osm_brasil.ways w
            WHERE tags -> 'highway' IS NOT NULL
        ) SELECT  s1.tags -> 'name' AS st_name_a,
                  s1.id AS st_id_a,
                  s2.id AS st_id_b,
                  s2.tags -> 'name' AS st_name_b,
                  osm_brasil.map_url('way', s1.id) as url_a, 
                  osm_brasil.map_url('way', s2.id) as url_b 
        FROM streets s1, streets s2
        WHERE s1.id <> s2.id AND
              st_intersects(s1.linestring, s2.linestring)
    ) SELECT * FROM crossing_streets cs;

    /*
    *
    * osm_brasil.crossed_by( st_id ) 
    *
    * Function that show all streets that crosses a given street ( st_id )
    *
    * (code found on SOF) :
    *   (1)/questions/7624919/check-if-a-user-defined-type-already-exists-in-postgresql
    */
    DO $$ BEGIN
        IF NOT EXISTS( SELECT 1 FROM pg_type WHERE typname = 't_crossed_st') THEN
            CREATE TYPE osm_brasil.t_crossed_st AS ( st_id BIGINT, st_name TEXT, st_url TEXT );
        END IF;
    END $$;
    -- SOF (1)

    CREATE OR REPLACE FUNCTION osm_brasil.crossed_by( st_id BIGINT )
    RETURNS SETOF osm_brasil.t_crossed_st AS
    $$
        SELECT st_id_b AS st_id ,
               st_name_b AS st_name,
               url_b AS st_url
        FROM osm_brasil.crossing_streets
        WHERE st_id_a = st_id
    $$
    LANGUAGE SQL;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
