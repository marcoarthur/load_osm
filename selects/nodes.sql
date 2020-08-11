/*

Show all places that are within a 15 meters distance from a river.

*/
SELECT n.id, n.tags
FROM osm_brasil.nodes n, osm_brasil.ways w
WHERE  w.tags -> 'waterway' = 'river' AND
       n.tags -> 'name' IS NOT NULL AND
       st_dwithin(w.linestring, n.geom, 15);

/* A function that do the same, but makes the distance as an option */
CREATE OR REPLACE FUNCTION osm_brasil.closer_than( distance INTEGER )
    RETURNS TABLE( id BIGINT, tags HSTORE ) AS
$$
BEGIN
    RETURN QUERY

    SELECT n.id, n.tags
    FROM osm_brasil.nodes n, osm_brasil.ways w
    WHERE  w.tags -> 'waterway' = 'river' AND
           n.tags -> 'name' IS NOT NULL AND
           st_dwithin(w.linestring, n.geom, distance);
END;
$$
LANGUAGE 'plpgsql';

