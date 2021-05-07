

/*
* 
* Descriptions for our dataset. Definition that comes from code.
*
*/


-- Bound box written in WKT - Well Known Text (https://en.wikipedia.org/wiki/Well-known_text)
-- A rectangular area defined by ( left_bottom, upper_rigth ) coordinates, which are
-- in lon/lat coordinates.
SELECT ST_AsText(ST_makeEnvelope(-45.091,-23.448,-45.066,-23.423)) AS DEFAULT_BBOX_WKT

-- Extract the same in GEOJSON format
SELECT ST_AsGeoJSON(ST_makeEnvelope(-45.091,-23.448,-45.066,-23.423)) AS DEFAULT_BBOX_GEOJSON

/*
* Investigate the tagging of data over time, so we can understand tagging data
* flows in a region.
*/

/*
* Polygon coordinates for each suburb in Ubatuba
*/



/*
* Using tstamp to see flow of data
*/
select n.tags, n.tstamp, osm_brasil.map_url('node', n.id)
from osm_brasil.nodes n
where tags <> ''
order by tstamp DESC;

/* same for areas */
select w.tags, w.tstamp, osm_brasil.map_url('way', w.id)
from osm_brasil.ways w
where tags <> ''
order by tstamp DESC;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=gis
