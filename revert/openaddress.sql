-- Revert load_brasil_osm:openaddress from pg

BEGIN;

    DROP TABLE osm_brasil.oaddr;

COMMIT;
