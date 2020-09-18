-- Deploy load_brasil_osm:view_st_noname to pg

BEGIN;

    /* Unnamed Streets with length greater than or equal 500 m */
    CREATE OR REPLACE VIEW osm_brasil.streets_without_name AS
    WITH unnamed_streets AS (
        SELECT osm_brasil.map_url('way', w.id),
               ST_Perimeter(ST_Transform(w.linestring, 3857)) / 1000 AS length,
               w.linestring AS geom
        FROM osm_brasil.ways w
        WHERE (
            tags -> 'name' IS NULL AND
            tags -> 'building' IS NULL AND -- prevent building
            tags -> 'natural' IS NULL AND -- prevent natural
            tags -> 'source' IS NULL -- prevent ibge source (generally natural)
        )
    ) SELECT *
    FROM unnamed_streets us
    WHERE us.length >= 0.5;

    COMMENT ON VIEW osm_brasil.streets_without_name IS
    'streets without tag name on it and greater than or equal 500 meters';

COMMIT;
