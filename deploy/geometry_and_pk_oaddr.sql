-- Deploy load_brasil_osm:geometry_and_pk_oaddr to pg

BEGIN;

    -- create a new geom column
    ALTER TABLE osm_brasil.oaddr 
    ADD COLUMN geom geometry(Point, 4326);

    -- update values
    UPDATE osm_brasil.oaddr SET geom = ST_SetSRID(ST_MakePoint(lon, lat), 4326);

    -- create indexes from oaddr
    CREATE INDEX oaddr_geom_idx ON osm_brasil.oaddr USING GIST(geom);

COMMIT;
-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
