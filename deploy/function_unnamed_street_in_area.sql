-- Deploy load_brasil_osm:function_unnamed_street_in_area to pg

BEGIN;

    CREATE OR REPLACE FUNCTION osm_brasil.unname_st_within( TEXT )
    RETURNS SETOF osm_brasil.streets_without_name AS
    $$
        SELECT *
        FROM osm_brasil.streets_without_name swn
        WHERE ST_Within(
            ST_Transform(swn.geom, 4326),
            ST_GeomFromText( $1, 4326)) = TRUE
        ORDER BY length
    $$
    LANGUAGE SQL;

COMMIT;
