/*
 All waterways and their length in meters
*/

SELECT 'https://www.openstreetmap.org/?way=' || w.id as url,
       w.tags -> 'name' AS river,
       ST_Perimeter(ST_Transform(w.linestring, 3857))/1000 AS length
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
        w.linestring
FROM osm_brasil.ways w
WHERE w.tags -> 'building' IS NOT NULL;
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

