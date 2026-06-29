-- Création de la base de données
CREATE DATABASE IF NOT EXISTS energy_db;
USE energy_db;

-- 1. Table externe pour les métadonnées des bâtiments
CREATE EXTERNAL TABLE IF NOT EXISTS ext_building_metadata (
    site_id INT,
    building_id INT,
    primary_use STRING,
    square_feet INT,
    year_built INT,
    floor_count INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE 
LOCATION '/user/student/energy/data/building_metadata'
TBLPROPERTIES ("skip.header.line.count"="1");

-- 2. Table externe pour les données météo
CREATE EXTERNAL TABLE IF NOT EXISTS ext_weather (
    site_id INT,
    timestamp TIMESTAMP,
    air_temperature FLOAT,
    cloud_coverage FLOAT,
    dew_temperature FLOAT,
    precip_depth_1_hr FLOAT,
    sea_level_pressure FLOAT,
    wind_direction FLOAT,
    wind_speed FLOAT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE 
LOCATION '/user/student/energy/data/weather'
TBLPROPERTIES ("skip.header.line.count"="1");

-- 3. Table externe pour les relevés de compteurs
CREATE EXTERNAL TABLE IF NOT EXISTS ext_meter_readings (
    building_id INT,
    meter INT,
    timestamp TIMESTAMP,
    meter_reading FLOAT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE 
LOCATION '/user/student/energy/data/meter_readings'
TBLPROPERTIES ("skip.header.line.count"="1");
