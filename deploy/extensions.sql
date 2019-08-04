-- Deploy load_brasil_osm:extensions to pg
-- requires: appschema

BEGIN;

	CREATE EXTENSION hstore;
	CREATE EXTENSION postgis;
	CREATE EXTENSION postgis_topology;

COMMIT;
