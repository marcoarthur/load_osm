-- Deploy load_brasil_osm:economy_view to pg

BEGIN;

CREATE OR REPLACE VIEW osm_brasil.business AS
SELECT osm_brasil.map_url('node', n.id) as url,
       n.geom,
       coalesce( n.tags->'amenity', n.tags->'tourism', n.tags->'shop' ) AS type
FROM osm_brasil.nodes n
WHERE n.tags <> '' AND
      ( n.tags->'amenity' IS NOT NULL OR
        n.tags->'tourism' IS NOT NULL OR
        n.tags->'shop' IS NOT NULL );


CREATE OR REPLACE VIEW osm_brasil.summary_business AS
SELECT b.type,
       count(*) as total
FROM osm_brasil.business b
GROUP BY type 
ORDER BY total;

CREATE OR REPLACE FUNCTION osm_brasil.summary_business_by_area( area geometry(Geometry,4326) )
RETURNS SETOF osm_brasil.summary_business AS
$$
      SELECT b.type,
             count(*) as total
      FROM osm_brasil.business b
      WHERE st_within( b.geom, area )
      GROUP BY type
      ORDER BY total;
$$
LANGUAGE SQL;

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
