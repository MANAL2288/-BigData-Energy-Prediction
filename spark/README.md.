
Cette partie du projet concerne l'analyse, le nettoyage et la modélisation prédictive de la consommation énergétique en utilisant le moteur **Apache Spark** via des notebooks **Apache Zeppelin**.

## Technologies utilisées
* **Spark 2.3** (HDP 3.0)
* **PySpark** : Pour le chargement et l'analyse exploratoire.
* **Scala** : Pour le pipeline de Machine Learning (choisi pour ses performances natives et la compatibilité avec l'environnement).
* **Spark MLlib** : Bibliothèque de Machine Learning distribué.

## Pipeline de traitement
1. **Chargement & Persistance** : Importation des données depuis Hive et HDFS. Utilisation de la stratégie `.cache()` pour optimiser les calculs sur les 20 millions de lignes.
2. **Exploration (EDA)** : Analyse des valeurs manquantes et visualisation de la consommation horaire via Spark SQL.
3. **Feature Engineering** : 
   * Nettoyage des données aberrantes.
   * Extraction des caractéristiques temporelles (Heure, Jour, Mois).
   * Encodage des variables catégorielles avec `StringIndexer`.
4. **Modélisation** : Entraînement comparatif de deux algorithmes :
   * Régression Linéaire.
   * Random Forest Regressor.
5. **Évaluation** : Mesure de la précision via les métriques RMSE, MAE et R².
6. 
## Gestion de la Qualité des Données (Valeurs NULL)

Lors de la phase d'analyse exploratoire, nous avons identifié des valeurs manquantes (**NULL**) importantes dans le dataset d'origine (ASHRAE). 

### Pourquoi ces valeurs nulles ?
Ces lacunes proviennent de la collecte initiale des données réelles :
* **`floor_count` (Nombre d'étages)** et **`year_built` (Année de construction)** sont les colonnes les plus impactées. Ces informations n'ont pas été systématiquement renseignées par les gestionnaires des bâtiments lors de l'enregistrement des métadonnées.

### Traitement appliqué dans Spark :
Pour garantir la robustesse des modèles de Machine Learning, nous avons appliqué les transformations suivantes :
1. **Suppression de colonnes (Dropping)** : La colonne `floor_count` a été supprimée car elle contenait trop de valeurs manquantes pour être statistiquement significative.
2. **Filtrage des anomalies** : Nous avons filtré les enregistrements où la consommation (`meter_reading`) était nulle ou manquante, ce qui pouvait correspondre à des périodes de panne de compteurs.

Cette étape de **nettoyage** est cruciale car les algorithmes de régression (Régression Linéaire, Random Forest) nécessitent des entrées numériques complètes pour fonctionner de manière optimale.
## Pourquoi Scala ?
Nous avons basculé l'implémentation du Machine Learning en **Scala** pour garantir la robustesse du pipeline. Spark étant écrit en Scala, cela permet une exécution plus stable sur de gros volumes de données et évite les dépendances externes (comme `numpy` en Python) qui n'étaient pas disponibles dans l'environnement contraint de la Sandbox HDP.

## Résultats
Les résultats montrent que le modèle **Random Forest** est plus performant pour capturer la complexité des cycles énergétiques par rapport à une régression linéaire classique.
