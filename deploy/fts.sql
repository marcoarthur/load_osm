-- Deploy load_brasil_osm:fts to pg

BEGIN;

	ALTER TABLE osm_brasil.ways ADD COLUMN ways_fts tsvector;
	UPDATE osm_brasil.ways SET ways_fts  =
		  to_tsvector('portuguese', coalesce(tags->'name',''));

	CREATE INDEX fts_ways_idx ON osm_brasil.ways USING gin (ways_fts);

COMMIT;
