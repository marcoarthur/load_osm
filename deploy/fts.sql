-- Deploy load_brasil_osm:fts to pg

BEGIN;

	ALTER TABLE ways ADD COLUMN ways_fts tsvector;
	UPDATE ways SET ways_fts  =
		 to_tsvector('portuguese', coalesce(tags->'name',''));

	CREATE INDEX fts_ways_idx ON ways USING GIN (ways_fts);

COMMIT;
