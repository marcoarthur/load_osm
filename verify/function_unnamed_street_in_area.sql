-- Verify load_brasil_osm:function_unnamed_street_in_area on pg

BEGIN;

    SELECT has_function_privilege('osm_brasil.unname_st_within(TEXT)', 'execute');

ROLLBACK;
