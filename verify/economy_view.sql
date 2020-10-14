-- Verify load_brasil_osm:economy_view on pg

BEGIN;

    SELECT * FROM osm_brasil.business LIMIT 1;
    SELECT * FROM osm_brasil.summary_business LIMIT 1;
    SELECT * 
    FROM osm_brasil.summary_business_by_area( ST_BUFFER(  ST_SetSRID(ST_MakePoint(-44.2067200, -23.4734820),4326), 0.7 ) );

ROLLBACK;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
