-- Verify load_brasil_osm:bbox on pg

BEGIN;

	SET search_path TO osm_brasil,public,topology;
	SELECT bbox FROM ways LIMIT 1;

ROLLBACK;
