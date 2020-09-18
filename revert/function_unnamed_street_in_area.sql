-- Revert load_brasil_osm:function_unnamed_street_in_area from pg

BEGIN;

    DROP FUNCTION osm_brasil.unname_st_within( TEXT );

COMMIT;
