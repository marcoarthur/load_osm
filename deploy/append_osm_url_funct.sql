-- Deploy load_brasil_osm:append_osm_url_funct to pg

BEGIN;

    CREATE OR REPLACE FUNCTION osm_brasil.map_url( tbl TEXT, id  BIGINT )
    RETURNS TEXT AS $$
    DECLARE str TEXT;
    DECLARE arg TEXT;
    BEGIN
        arg := lower(tbl);
        IF arg NOT IN('way','node') THEN
            RAISE EXCEPTION 'NOT valid Argument';
        END IF;
        str := 'https://www.openstreetmap.org/?' || arg || '=' || id;
        RETURN str;
    END;
    $$
    LANGUAGE 'plpgsql';

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
