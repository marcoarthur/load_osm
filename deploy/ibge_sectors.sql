-- Deploy load_brasil_osm:ibge_sectors to pg

BEGIN;

    -- Create a temporary table with the json data
    CREATE TEMP TABLE t_aux( j jsonb );
    COPY t_aux FROM PROGRAM 'curl https://gist.githubusercontent.com/marcoarthur/2f0fde0972363c4344659ad7f06a1267/raw/c1b6fcd7cfdc4f44077c2cb75572e8f1b7658a6f/regioes_sensitarias_ubatuba.geojson';

    -- Extract information from json and save it on table ibge_sectors
    SELECT properties->>'name' AS id, ST_GeomFromGeoJson(geometry) AS geom
    INTO TABLE osm_brasil.ibge_sectors
    FROM t_aux, jsonb_to_recordset(t_aux.j->'features') AS ele(type text, geometry text, properties jsonb);

    -- Update SRID for ibge_sectors geometry
    SELECT UpdateGeometrySRID('osm_brasil','ibge_sectors', 'geom', 4326);
    
COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
