#!/bin/sh

# Create the data folder.
hdfs dfs -mkdir /data

# Move the data from local system file to hadoop cluster.
hdfs dfs -put ./crayons.csv /data/crayons.csv

# Create the database.
impala-shell -i localhost:21000 -q 'CREATE DATABASE wax'

# Create the table crayons from the warehouse.
impala-shell -i localhost:21000 -q '
  CREATE TABLE wax.crayons (
    `color` STRING,
    `hex` STRING,
    `red` SMALLINT,
    `green` SMALLINT,
    `blue` SMALLINT,
    `pack` SMALLINT)
  ROW FORMAT DELIMITED FIELDS TERMINATED BY ","
  LOCATION "hdfs:///data/";'
