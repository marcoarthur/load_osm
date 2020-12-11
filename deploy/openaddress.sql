-- Deploy load_brasil_osm:openaddress to pg

BEGIN;

    CREATE TABLE osm_brasil.oaddr (
        LON numeric,
        LAT numeric,
        "NUMBER" text,
        STREET text,
        UNIT text,
        CITY text,
        DISTRICT text,
        REGION text,
        POSTCODE text,
        ID text,
        HASH text
    );

COMMIT;

-- dbext:type=PGSQL:user=devel:host=127.0.0.1:dbname=make_test
