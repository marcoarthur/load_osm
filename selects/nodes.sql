/*
 All waterways and their length in meters
*/

SELECT 'https://www.openstreetmap.org/?way=' || w.id as url,
       w.tags -> 'name' AS river,
       ST_Perimeter(ST_Transform(w.linestring, 3857))/1000 AS length,
       w.linestring AS geom
FROM osm_brasil.ways w
WHERE w.tags -> 'waterway' IS NOT NULL
ORDER BY length;


/*
  Search for buildings as nodes
*/

SELECT 'https://www.openstreetmap.org/?node=' || n.id as url,
        n.tags,
        n.geom 
FROM osm_brasil.nodes n
WHERE n.tags -> 'building' is not null;

/*
 Search buildings as ways
*/

SELECT 'https://www.openstreetmap.org/?way=' || w.id as url,
        w.tags,
        ST_Area(ST_Transform(w.linestring, 3857)) AS area
FROM osm_brasil.ways w
WHERE w.tags -> 'building' IS NOT NULL OR
      w.tags -> 'building:part' IS NOT NULL
ORDER BY area;

SELECT  w.id,
        w.tags -> 'name' AS river,
        ST_Perimeter(ST_Transform(w.linestring, 3857)) AS length
FROM osm_brasil.ways w
WHERE w.tags -> 'waterway' IS NOT NULL;

/*
Tagged nodes with names, and inside ubatuba boundaries
*/

SELECT n.tags::jsonb,
       n.geom
FROM osm_brasil.nodes n
WHERE n.tags -> 'name' <> '';

/*
Not tagged
*/

SELECT count(*) FROM osm_brasil.nodes n WHERE n.tags IS NULL OR n.tags = '';

/*
Tagged
*/
SELECT count(*) FROM osm_brasil.nodes n WHERE n.tags <> '';

/*
Relations
*/

SELECT 'https://www.openstreetmap.org/?relation=' || r.id as url, 
        *
FROM osm_brasil.relations r;

/* Beachs */
SELECT 'https://www.openstreetmap.org/?way=' || w.id as url,
       w.tags,
       st_area(st_transform(w.linestring, 26986))/1000000 as area_kms
from osm_brasil.ways w
where w.tags -> 'natural' = 'beach'
order by area_kms desc;

/*

Tags distribution. What is the tag most used (keys on tags key => value pair )

*/

WITH ntags( tag, count ) AS (
    SELECT key, count(*)
    FROM ( SELECT (each(tags)).key FROM osm_brasil.nodes) AS stat
    GROUP BY key
    ORDER BY count DESC,key
) SELECT * FROM ntags;

/*
Show all places that are within a 15 meters distance from a river.
*/
SELECT 'https://www.openstreetmap.org/?node=' || n.id as url,
n.id, n.tags,
ST_Distance( ST_Transform(n.geom,3857) , ST_Transform(w.linestring,3857)) as distance
FROM osm_brasil.nodes n, osm_brasil.ways w
WHERE  (
        w.tags -> 'waterway' = 'river' OR
        w.tags -> 'waterway' = 'stream' OR
        w.tags -> 'waterway' = 'canal'
       )AND
       n.tags -> 'name' IS NOT NULL AND
       ST_dwithin( ST_Transform( w.linestring, 3857 ), ST_Transform(n.geom, 3857), 100 )
ORDER BY distance;

/* A function that do the same, but makes the distance as an option */
CREATE OR REPLACE FUNCTION osm_brasil.closer_than( distance INTEGER )
    RETURNS TABLE( id BIGINT, tags HSTORE ) AS
$$
BEGIN
    RETURN QUERY

    SELECT n.id, n.tags
    FROM osm_brasil.nodes n, osm_brasil.ways w
    WHERE (
            w.tags -> 'waterway' = 'river' OR
            w.tags -> 'waterway' = 'stream' OR
            w.tags -> 'waterway' = 'canal'
          ) AND
           n.tags -> 'name' IS NOT NULL AND
           st_dwithin( ST_Transform(w.linestring, 3857), ST_Transform(n.geom, 3857), distance);
END;
$$
LANGUAGE 'plpgsql';


/* Function that show url of object 

CREATE OR REPLACE FUNCTION osm_brasil.url( tbl TEXT )
    RETURNS TEXT AS
$$
BEGIN
    tbl_ := left(tbl, -1)
    RETURN 'https://www.openstreetmap.org/?' || tbl_ || '=' || tbl.id 
END;
$$
LANGUAGE 'plpgsql';
*/

/*
* Lombadas
*/

SELECT osm_brasil.map_url('node', id), n.tags
FROM osm_brasil.nodes n
WHERE (
    n.tags -> 'traffic_calming' IS NOT NULL
);

 -- Nice way to save cvs file
/* COPY (<put-query-here>) TO STDOUT WITH (FORMAT CSV);*/

SELECT osm_brasil.map_url('way', id),
         w.tags,
         st_perimeter(w.linestring) as l2,
         st_perimeter(st_transform(w.linestring, 3857)) / 1000 AS length
FROM osm_brasil.ways w
WHERE (
    w.tags -> 'highway' = 'track'
)
ORDER BY length;

/* CRS */

SELECT * FROM spatial_ref_sys WHERE srid = 3857;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
