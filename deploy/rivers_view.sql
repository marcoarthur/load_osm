-- Deploy load_brasil_osm:rivers_view to pg

BEGIN;

    CREATE OR REPLACE VIEW osm_brasil.rivers AS
    WITH river_tags(tag) AS (
        VALUES ('waterway', 'river', 'waterstream')
    ), river_list AS (
        SELECT osm_brasil.map_url('way', w.id) AS river_id,
               w.tags -> 'name' AS river_name,
               w.linestring AS geom
        FROM osm_brasil.ways w
        WHERE w.tags ?| ( ARRAY( SELECT tag FROM river_tags ) )
    ) SELECT * FROM river_list;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=gis
