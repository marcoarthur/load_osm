-- Revert load_brasil_osm:append_osm_url_funct from pg

BEGIN;

    DROP FUNCTION osm_brasil.map_url(TEXT, BIGINT);

COMMIT;
