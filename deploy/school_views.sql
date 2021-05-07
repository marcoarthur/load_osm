-- Deploy load_brasil_osm:school_views to pg

-- OSM Wiki reference:
-- https://wiki.openstreetmap.org/wiki/Education_features
BEGIN;

    CREATE VIEW osm_brasil.schools AS
    SELECT osm_brasil.map_url('node',n.id), *
    FROM  osm_brasil.nodes n
    WHERE ARRAY[ n.tags->'amenity' ] <@ 
          ARRAY[ 'school', 'kindergarten', 'university', 'centre', 'language_school','childcare', 'music_school' ];

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=gis
