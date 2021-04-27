-- Revert load_brasil_osm:ibge_sectors from pg

BEGIN;

    DROP table osm_brasil.ibge_sectors;

COMMIT;
