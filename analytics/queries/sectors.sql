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
-- Sectors and Node counts 
--

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
from rivers_sectors
group by url;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=gis
