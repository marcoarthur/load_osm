-- sectors related queries

--
-- Area of IBGE Sectors
--

WITH sector_areas AS (
      SELECT ID, ST_Area(ST_Transform(ST_MakePolygon(geom), 26986))/10^6 AS area_sqkm
      FROM osm_brasil.ibge_sectors
) SELECT *
FROM sector_areas
ORDER BY area_sqkm;

--
-- River crossing sectors
--

WITH rivers_sectors AS (
      SELECT 'https://www.openstreetmap.org/?way=' || w.id as url,
             w.tags -> 'name' AS river,
             ST_Perimeter(ST_Transform(w.linestring, 3857))/1000 AS length,
             ibs.id as sector_id
      FROM osm_brasil.ways w, osm_brasil.ibge_sectors ibs
      WHERE w.tags -> 'waterway' IS NOT NULL AND
            ST_Crosses(ibs.geom, w.linestring)
      ORDER BY length
) SELECT url, array_agg(sector_id) as sectors
FROM rivers_sectors
GROUP BY url;

--
-- Tagged nodes by sectors
--

WITH tagged_nodes_by_sector AS (
      SELECT ib.id AS sector_id,
             ST_Area(ST_Transform(ST_MakePolygon(ib.geom), 26986))/10^6 AS sector_area_km,
             ib.geom,
             count(*) AS total_tagged
      FROM osm_brasil.nodes n
           RIGHT JOIN osm_brasil.ibge_sectors ib ON
           ST_WITHIN(n.geom, ST_MakePolygon(ib.geom))
      WHERE n.tags <> ''
      GROUP BY ib.id, ib.geom
)
SELECT sector_id, sector_area_km, total_tagged / sector_area_km  AS density
FROM tagged_nodes_by_sector
ORDER BY density DESC;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=gis
