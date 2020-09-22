-- Deploy load_brasil_osm:view_big_areas to pg

BEGIN;

    /*
    * This view search for areas and measure the area size in km^2
    * And list the top 10 places
    */
    CREATE OR REPLACE VIEW osm_brasil.biggest_areas AS
    -- area_tags.tag represents the OSM tags that could represents be an area
    -- so linestring will be an area.
    WITH area_tags(tag) AS (
        VALUES ('leisure', 'area', 'natural')
    ), areas_list AS (
        SELECT  w.id,
                st_area(st_transform(w.linestring, 3857))/1000000 AS area,
                osm_brasil.map_url('way', w.id) AS url
        FROM osm_brasil.ways w
        -- Operator ?| states any of the ARRAY is present as key in w.tags
        WHERE w.tags ?| ( ARRAY( SELECT tag FROM area_tags ) )
        ORDER BY area DESC
    ) SELECT * FROM areas_list LIMIT 10;


    /*
    * This view counts tags used for ways and count them.
    * Ordering by most used to less used.
    */
    CREATE OR REPLACE VIEW osm_brasil.ways_count AS
    WITH way_tags( tag, count ) AS (
        SELECT key, count(*) as total
        FROM ( 
            SELECT (each(tags)).key
            FROM osm_brasil.ways w
        ) AS stat
        GROUP BY key
        ORDER BY total DESC, key
    ) SELECT * FROM way_tags;


COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
