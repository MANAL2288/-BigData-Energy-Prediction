--Mis à jour de la LOCATION pour pointer vers les dossiers créés par Sqoop 
ALTER TABLE ext_meter_readings SET LOCATION '/user/selharouchi/energy/data/full/meter_readings';
ALTER TABLE ext_weather SET LOCATION '/user/selharouchi/energy/data/full/weather';
ALTER TABLE ext_building_metadata SET LOCATION '/user/selharouchi/energy/data/full/building_metadata';
