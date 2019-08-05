-- Deploy load_brasil_osm:pgtap to pg

BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap;

COMMIT;
