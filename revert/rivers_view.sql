-- Revert load_brasil_osm:rivers_view from pg

BEGIN;

    DROP VIEW osm_brasil.rivers;

COMMIT;
