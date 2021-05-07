/*
* A first example to find the KNN (K=3) nearest business to a given school
* School example id ( 4557143079 )
*/

SELECT * -- all business field
FROM osm_brasil.business b
-- Here we use geometry POINT using the KNN operator to the value returned by
-- the subquery identifying a school by ID (4557143079).
ORDER BY b.geom <-> ( SELECT s.geom FROM osm_brasil.schools s WHERE s.id = 4557143079 ) LIMIT 3;

/*
*
* This generalize previous query for all schools finding the 3 _nearest_ business.
*
*/

SELECT sch.id AS school_id, 
       sch.map_url AS school_url,
       b.url AS business_url,
       b.type AS business_type,
       -- distance in meters from school and the business
       ST_Distance( ST_Transform(sch.geom, 3857), ST_Transform( b.geom, 3857 ) ) AS distance
FROM osm_brasil.schools sch LEFT JOIN LATERAL (
    SELECT *
    FROM osm_brasil.business
    WHERE sch.map_url <> url -- because business table also include schools as business 
    ORDER BY geom <-> sch.geom LIMIT 3
) AS b ON true;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
