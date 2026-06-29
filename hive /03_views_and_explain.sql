--Pour répondre aux exigences de "Vues métiers" et "Explain".
USE energy_db;

-- Création d'une Vue Métier Elle sert à détecter les bâtiments qui consomment trop par rapport à leur taille.
--But : "Cette vue permet d'identifier les dérives anormales en calculant un indice de performance énergétique par m²."
CREATE VIEW IF NOT EXISTS view_anomaly_detection AS
SELECT 
    m.building_id, 
    b.primary_use, 
    m.meter_reading / b.square_feet as energy_index -- Consommation au m2
FROM managed_meter_readings m
JOIN ext_building_metadata b ON m.building_id = b.building_id;



--Création d'une Vue Matérialisée 
-- Elle sert à l'optimisation des budgets par service gestionnaire (demandé dans le sujet).
--But: Nous matérialisons cette vue car les calculs budgétaires par secteur (santé, éducation) sur 20M de lignes sont coûteux. La matérialisation permet un accès instantané aux rapports financiers
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_budget_optimization
AS
SELECT 
    primary_use, 
    SUM(meter_reading) as total_conso,
    AVG(meter_reading) as avg_conso
FROM managed_meter_readings m
JOIN ext_building_metadata b ON m.building_id = b.building_id
GROUP BY primary_use;

--REBUILD de la vue matérialisée pour s'assurer que les données sont à jour après sa création
ALTER MATERIALIZED VIEW mv_budget_optimization REBUILD;


---Commandes EXPLAIN pour analyser les plans d'exécution des requêtes sur les vues:
--Analyse de la requête sur la vue métier
EXPLAIN SELECT * FROM view_anomaly_detection WHERE energy_index > 50;

--Analyse de la requête sur la vue matérialisée
EXPLAIN SELECT primary_use, total_conso FROM mv_budget_optimization;

--Cette commande nous permet de vérifier que la vue matérialisée est bien créée et de voir les détails de son stockage, ce qui est crucial pour comprendre les performances.
DESCRIBE FORMATTED mv_budget_optimization;
