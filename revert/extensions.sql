-- Revert load_brasil_osm:extensions from pg

BEGIN;

	DROP EXTENSION hstore;
	DROP EXTENSION postgis;
	DROP EXTENSION postgis_topology;

COMMIT;
