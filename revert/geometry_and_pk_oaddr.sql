-- Revert load_brasil_osm:geometry_and_pk_oaddr from pg

BEGIN;

    DROP INDEX osm_brasil.oaddr_geom_idx;
    ALTER TABLE osm_brasil.oaddr DROP COLUMN geom;

COMMIT;
-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
