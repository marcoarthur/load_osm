-- Revert load_brasil_osm:school_views from pg

BEGIN;

    DROP VIEW osm_brasil.schools;

COMMIT;
