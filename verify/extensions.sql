-- Verify load_brasil_osm:extensions on pg

BEGIN;

	SELECT 1 / count(*) FROM pg_extension WHERE extname = 'hstore';
	SELECT 1 / count(*) FROM pg_extension WHERE extname = 'postgis';
	SELECT 1 / count(*) FROM pg_extension WHERE extname = 'postgis_topology';

ROLLBACK;
