-- Deploy load_brasil_osm:appschema to pg

BEGIN;

	CREATE SCHEMA osm_brasil;

COMMIT;
