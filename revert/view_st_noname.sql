-- Revert load_brasil_osm:view_st_noname from pg

BEGIN;

    DROP VIEW osm_brasil.streets_without_name;

COMMIT;
