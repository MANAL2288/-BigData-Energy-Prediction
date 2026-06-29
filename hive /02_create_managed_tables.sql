--C'est ici qu'on applique le format Parquet, le partitionnement et les contraintes demandés par le prof.
USE energy_db;
-- On crée une table propre et optimisée (Format Parquet + Partitionnée)
-- On partitionne par 'meter' (0=élec, 1=eau, etc.) car c'est efficace pour filtrer
CREATE TABLE IF NOT EXISTS managed_meter_readings (
    building_id INT NOT NULL, -- Contrainte NOT NULL
    timestamp TIMESTAMP,
    meter_reading FLOAT
)
PARTITIONED BY (meter_type INT) 
STORED AS PARQUET; -- Format demandé

-- Section : Fiabilisation des données
-- Ajout d'une contrainte CHECK pour interdire les consommations énergétiques négatives
ALTER TABLE managed_meter_readings 
ADD CONSTRAINT check_conso_positive CHECK (meter_reading >= 0.0) DISABLE NOVALIDATE;

-- Activation du partitionnement dynamique
SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;

-- Insertion des données depuis la table externe vers la managée
INSERT INTO TABLE managed_meter_readings PARTITION(meter_type)
SELECT building_id, timestamp, meter_reading, meter as meter_type 
FROM ext_meter_readings;


EXPLAIN SELECT meter_type, AVG(meter_reading) 
FROM managed_meter_readings 
WHERE meter_type = 1
GROUP BY meter_type;
