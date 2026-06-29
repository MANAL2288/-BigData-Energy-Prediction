# Commande pour importer les données de PostgreSQL vers HDFS
# Note : PostgreSQL a été configuré en mode 'trust' pour permettre l'importation

#1. Ingestion de la meter_readings
sqoop import --connect jdbc:postgresql://localhost/energy_db \
--username postgres \
--table meter_readings \
--target-dir /user/selharouchi/energy/data/full/meter_readings \
--m 1

# 2. Ingestion de la météo (Weather)
sqoop import --connect jdbc:postgresql://localhost/energy_db --username postgres --table weather --target-dir /user/selharouchi/energy/data/full/weather --m 1

#3. Ingestion des métadonnées des bâtiments (Building Metadata)
sqoop import --connect jdbc:postgresql://localhost/energy_db --username postgres --table building_metadata --target-dir /user/selharouchi/energy/data/full/building_metadata --m 1
