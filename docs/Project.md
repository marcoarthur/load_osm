---
title: Analysis for Ubatuba dataset from OSM
author: Marco Arthur
date: Mon Apr 26 2021
bibliography: bib/default.bib
---


# Data importation

All geographical data comes from OSM project and are imported in database using
the following tools:

 - [osmosis](https://wiki.openstreetmap.org/wiki/Osmosis)
 - [osm2pgsql](https://wiki.openstreetmap.org/wiki/Osm2pgsql)
 - [imposm](https://imposm.org/docs/imposm/latest/)

Each of these tools create a different schema most important problem is to keep
the data in sync with data that comes from OSM, we need to program script to
verify data sources changes and update them. The tools above
can sometimes be directly used to update data.

# Deployment and Requirements

In order to deploy this database application we require:

1. PostGRESQL database and PG extensions: PostGIS and PGTap.
2. Make and Perl
3. App::Sqitch database development tool.
4. All source data tools from previous section.
5. Pg::Prove tool for running test

If all requirements are installed, a makefile creates database and run
all steps needed in order to deploy.

```{bash}
make help # to see all environment variable and options to deploy
make # to deploy, load data, and test deployment
```

# Data Analytics Goals

We want to save geographical data that relates to administrative borders of
this city, searching many places I couldn't find some of administrative borders
representing neighbourhood. Official source in Brazil is related to IBGE and
their census, where this roughly represents what in a city a neighbourhood.

In Ubatuba-SP we counted a total of 409 census areas, many overlaps. Summing
a total area of 2352.74 km^2 much larger than the official area of 723.88 km^2.

# Drawing areas

Drawing areas to be able to search through it, that is 
One idea is to have a target area to

# Helper functions in database system

