-- Revert load_brasil_osm:schema_defs from pg

BEGIN;

-- Drop all tables if they exist.
SET search_path TO osm_brasil,public,topology;
DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS nodes;
DROP TABLE IF EXISTS node_tags;
DROP TABLE IF EXISTS ways;
DROP TABLE IF EXISTS way_nodes;
DROP TABLE IF EXISTS way_tags;
DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS relation_members;
DROP TABLE IF EXISTS relation_tags;
DROP TABLE IF EXISTS schema_info;

-- Drop all stored procedures if they exist.
DROP FUNCTION IF EXISTS osmosisUpdate();


COMMIT;
