-- Deploy load_brasil_osm:linestring to pg
-- From /usr/share/doc/osmosis/examples/pgsnapshot_schema_0.6_linestring.sql

BEGIN;
 
SET search_path TO osm_brasil,public,topology;

-- Add a postgis GEOMETRY column to the way table for the purpose of storing the full linestring of the way.
SELECT AddGeometryColumn('ways', 'linestring', 4326, 'GEOMETRY', 2);

-- Add an index to the bbox column.
CREATE INDEX idx_ways_linestring ON ways USING gist (linestring);

-- Cluster table by geographical location.
CLUSTER ways USING idx_ways_linestring;

COMMIT;
