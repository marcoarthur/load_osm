SET client_min_messages TO warning; 
CREATE EXTENSION IF NOT EXISTS pgtap; 
RESET client_min_messages; 

BEGIN; 

SELECT no_plan(); 

SELECT has_schema( 'osm_brasil', 'schema presence' );

-- Check for all tables in application
SELECT has_table('osm_brasil', n, 'should have table osm_brasil.' || n )
FROM (
	WITH tnames(n) AS (
		VALUES
		('schema_info'),
		('users'),
		('nodes'),
		('node_tags'),
		('ways'),
		('way_nodes'),
		('way_tags'),
		('relations'),
		('relation_members'),
		('relation_tags')
	)
	SELECT n FROM tnames
) AS t;

SELECT finish(); 
ROLLBACK; 

-- dbext:type=PGSQL:user=gis:host=127.0.0.1:dbname=lbo
