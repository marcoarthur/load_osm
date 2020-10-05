-- Revert load_brasil_osm:economy_view from pg

BEGIN;

    DROP VIEW osm_brasil.summary_business;
    DROP VIEW osm_brasil.business;

COMMIT;
