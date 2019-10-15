# Database settings
TEST_DIR = t
DB_USER = devel
DB_HOST = 127.0.0.1
DB_DBNAME = make_test
PG_PROVE_FLAGS = -v
DB_SCHEMA = osm_brasil
DB_URI = db:pg://$(DB_USER)@$(DB_HOST)/$(DB_DBNAME)

# Osmosis settings
DATA_DIR = /tmp/var/data
OSM_FILE = osm_data.osm
OSM_TASK_BUFF = --buffer bufferCapacity=10000 
OSM_TASK_WRITE = --write-pgsql-dump-0.6 \
				enableBboxBuilder=true  enableLinestringBuilder=true \
				nodeLocationStoreType=CompactTempFile \
				directory=$(DATA_DIR)
OSM_FLAG = -v 100
OSM_TASK_READ  = --read-xml file=$(OSM_FILE)
OSMOSIS_FLAGS = $(OSM_FLAG) $(OSM_TASK_READ) $(OSM_TASK_WRITE)
LOAD_FILE = $(PWD)/script/load_data.sql
OSM_BBOX = "-45.091,-23.448,-45.066,-23.423"
OSM_API = "https://api.openstreetmap.org/api/0.6/map?bbox="

.PHONY: revert deploy test all

all: deploy load test

deploy:
	createdb -U devel -h 127.0.0.1 make_test || true
	sqitch deploy $(DB_URI)

osm_data.osm: 
	wget -O $(OSM_FILE) $(OSM_API)$(OSM_BBOX)

load: $(OSM_FILE) $(LOAD_FILE)
	mkdir -p $(DATA_DIR)
	osmosis $(OSMOSIS_FLAGS)
	cd $(DATA_DIR) && psql -U $(DB_USER) -h $(DB_HOST) -d $(DB_DBNAME) -f $(LOAD_FILE)

test: deploy
	 pg_prove $(PG_PROVE_FLAGS) -U $(DB_USER) -h $(DB_HOST) -d $(DB_DBNAME) $(TEST_DIR)/*

revert:
	sqitch revert -y $(DB_URI)
	rm -rf $(OSM_FILE)
	rm -rf $(DATA_DIR)
