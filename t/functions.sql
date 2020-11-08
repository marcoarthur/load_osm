BEGIN; 
SELECT no_plan(); 

PREPARE call_map_url AS SELECT osm_brasil.map_url('way', 10);
PREPARE map_url_result  AS VALUES ('https://www.openstreetmap.org/?way=10'::text);

SELECT results_eq( 'call_map_url', 
    'map_url_result', 'osm_brasil.map_url()' );


SELECT finish(); 
ROLLBACK;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
