-- Verify load_brasil_osm:append_osm_url_funct on pg

BEGIN;

    SELECT has_function_privilege('osm_brasil.map_url(text, bigint)', 'execute');

ROLLBACK;
