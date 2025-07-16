🧠 Titre du projet : Analyse commerciale d'une base musicale — Tableau de bord interactif sous Power BI
🔍 Contexte du projet
Ce projet s'inscrit dans un exercice pratique de modélisation de données et de visualisation interactive à partir de la base de données relationnelle Chinook, qui simule une plateforme de vente de musique (albums, artistes, titres, clients, factures...).

🎯 Objectifs
Explorer la structure relationnelle d’une base de données complexe (CSV + schéma relationnel).

Nettoyer, transformer et modéliser les données sous Power BI.

Créer un tableau de bord interactif pour fournir une vision globale des ventes, une analyse par artiste et une analyse par album.

🛠️ Étapes techniques réalisées

Exploration initiale des données via SQL sur BigQuery afin d’identifier les jointures clés et valider la qualité des données sources.

Exploitation des données sur BigQuery 

Importation des données sources (CSV) dans Power BI via Power Query.

Création du modèle de données selon les relations clés (Artiste → Album → Track → InvoiceLine → Invoice).

Calcul de mesures DAX personnalisées : total ventes, nombre de factures, ventes par artiste/album, moyenne par client, etc.

Mise en place de segments dynamiques (année, pays).

Construction de 3 pages de rapport avec visuels clairs, réactifs et adaptés : KPI, bar charts, pie charts.

Travail sur l’ergonomie et la lisibilité du tableau de bord.

📊 Résultat final
Une interface Power BI interactive, structurée autour de trois axes :

Page 1 : Analyse globale des ventes (vue synthétique)

Page 2 : Analyse des artistes (top artistes et répartition)

Page 3 : Analyse des albums (top albums et chiffre d’affaires)

Le tout conçu pour être utilisable par un manager ou une équipe marketing souhaitant optimiser le catalogue musical.

💼 Compétences mobilisées
Power BI (modélisation, DAX, visualisation)

Power Query (transformation de données)

Analyse de données relationnelles

Data storytelling
