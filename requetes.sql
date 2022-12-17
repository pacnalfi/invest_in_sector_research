
# 4.3 
SELECT U.intitule AS activite, COUNT(C.siren) AS nb_siren, (SUM(C.CA)/1000000) AS sum_CA
FROM chiffres_cles C, stockUL S, codeActiviteUL U
WHERE C.siren = S.siren
AND S.activitePrincipaleUniteLegale = U.code
AND C.annee = '2022'
AND C.CA > 1
GROUP BY S.activitePrincipaleUniteLegale
ORDER BY SUM(C.CA) DESC
LIMIT 0, 10;

# 4.4
SELECT U.intitule AS activite, C.siren AS siren, (C.CA)/1000000 AS CA
FROM chiffres_cles C, stockUL S, codeActiviteUL U
WHERE C.siren = S.siren
AND S.activitePrincipaleUniteLegale = U.code
AND C.annee = '2022'
AND C.CA > 1
AND C.siren != '712034040'
AND (U.code = '47.11F' OR U.code = '45.11Z' OR U.code ='10.12Z');

#4.5
SELECT S.activitePrincipaleUniteLegale AS Activite, C.num_dept AS Dept, SUM(C.CA) AS Somme_CA
FROM chiffres_cles C, stockUL S
WHERE C.siren = S.siren
AND C.annee = '2022'
GROUP BY C.num_dept
ORDER BY SUM(C.CA) DESC
LIMIT 0, 20;

#4.6
SELECT C.effectif as Effectif, (C.CA)/1000000 as CA
FROM chiffres_cles C
WHERE C.annee = '2022'
AND C.effectif > 1
AND C.CA > 1
AND C.CA < 1000000000;

## figure 4.7 CA_2020 - CA_2022 - Taux de changement en %
SELECT
  codeActiviteUL.intitule,
  SUM(CASE WHEN chiffres_cles.annee = 2020 THEN chiffres_cles.CA ELSE 0 END) AS CA_2020,
  SUM(CASE WHEN chiffres_cles.annee = 2022 THEN chiffres_cles.CA ELSE 0 END) AS CA_2022,
  (SUM(CASE WHEN chiffres_cles.annee = 2022 THEN chiffres_cles.CA ELSE 0 END) - SUM(CASE WHEN chiffres_cles.annee = 2020 THEN chiffres_cles.CA ELSE 0 END)) / SUM(CASE WHEN chiffres_cles.annee = 2020 THEN chiffres_cles.CA ELSE 0 END) * 100 AS change_in_percentage
FROM
  stockUL
INNER JOIN
  codeActiviteUL
    ON stockUL.activitePrincipaleUniteLegale = codeActiviteUL.code
INNER JOIN
  chiffres_cles
    ON stockUL.siren = chiffres_cles.siren
GROUP BY
  codeActiviteUL.intitule
ORDER BY change_in_percentage DESC
LIMIT 10;

##4.8
SELECT stockUL.activitePrincipaleUniteLegale AS activite, (SUM(chiffres_cles.CA)/1000000) AS annee_2020
FROM chiffres_cles, stockUL
WHERE chiffres_cles.siren = stockUL.siren
AND chiffres_cles.annee = '2020'
AND chiffres_cles.CA > 1
AND (stockUL.activitePrincipaleUniteLegale = '47.11F' OR stockUL.activitePrincipaleUniteLegale = '45.11Z' OR stockUL.activitePrincipaleUniteLegale = '10.12Z' OR stockUL.activitePrincipaleUniteLegale = '46.51Z' OR stockUL.activitePrincipaleUniteLegale = '29.10Z' OR stockUL.activitePrincipaleUniteLegale = '30.20Z' OR stockUL.activitePrincipaleUniteLegale = '46.46Z' OR stockUL.activitePrincipaleUniteLegale = '46.17A' OR stockUL.activitePrincipaleUniteLegale = '46.36Z' OR stockUL.activitePrincipaleUniteLegale = '47.71Z')
GROUP BY stockUL.activitePrincipaleUniteLegale
ORDER BY SUM(chiffres_cles.CA) DESC;
