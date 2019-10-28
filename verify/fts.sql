-- Verify load_brasil_osm:fts on pg

BEGIN;

	-- column was created
	SELECT ways_fts FROM ways;

	-- index was created
	SELECT count(*) > 0
	FROM pg_class c
	WHERE c.relname = 'fts_ways_idx ' 
	AND c.relkind = 'i';

ROLLBACK;
