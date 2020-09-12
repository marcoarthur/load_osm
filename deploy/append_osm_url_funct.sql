-- Deploy load_brasil_osm:append_osm_url_funct to pg

BEGIN;

    CREATE OR REPLACE FUNCTION osm_brasil.map_url( tbl TEXT, id  BIGINT )
    RETURNS TEXT AS $$
    DECLARE str TEXT;
    BEGIN
        str := 'https://www.openstreetmap.org/?' || tbl || '=' || id;
        RETURN str;
    END;
    $$
    LANGUAGE 'plpgsql';

COMMIT;
