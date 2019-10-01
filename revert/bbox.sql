-- Revert load_brasil_osm:bbox from pg

BEGIN;

	--  Set the search path first
	SET search_path TO osm_brasil,public,topology;

	-- Drop bbox column
	ALTER TABLE ways
	DROP COLUMN bbox CASCADE;

	-- Drop function
	DROP FUNCTION IF EXISTS first_agg( anyelement, anyelement ) CASCADE;

COMMIT;
