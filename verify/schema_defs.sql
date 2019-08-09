-- Verify load_brasil_osm:schema_defs on pg

BEGIN;

	SET search_path TO osm_brasil,public,topology;
	select * from schema_info;
	select * from users;
	select * from nodes;
	select * from node_tags;
	select * from ways;
	select * from way_nodes;
	select * from way_tags;
	select * from relations;
	select * from relation_members;
	select * from relation_tags;

ROLLBACK;
