


-- 1.Calculer le nombre d’Albums présent sur l’app Chinook

SELECT COUNT(Distinct title)        -- ou bien , COUNT(*), COUNT(distinct AlbumId)
FROM databird-2025.Chinook.Album;


-- 2. **Calculer le nombre total de factures émises par pays**:

SELECT 
  BillingCountry, 
  COUNT(*) AS TotalInvoices
FROM `databird-2025.Chinook.Invoice`
GROUP BY BillingCountry;





-- 1. **Lister tous les albums d'un artiste spécifique (e.g., "AC/DC"):

SELECT a.Title 
FROM `databird-2025.Chinook.Album` a
JOIN `databird-2025.Chinook.Artist` ar 
  ON a.ArtistId = ar.ArtistId
WHERE ar.Name = 'AC/DC';


-- 2. **Revenu total généré par chaque Artist de musique**:

SELECT
  ar.Name,
  SUM(il.Quantity * il.UnitPrice) as total_revenue
FROM `databird-2025.Chinook.InvoiceLine` il
JOIN `databird-2025.Chinook.Track` t 
  ON il.TrackId = t.TrackId
JOIN `Chinook.Album` al 
  ON al.AlbumId = t.AlbumId
JOIN `Chinook.Artist` ar 
  ON ar.ArtistId = al.ArtistId
GROUP BY 1
ORDER BY 2 DESC;

# window fonction

SELECT
  ar.Name as nom_artist,
  t.Name as titre,
  SUM(il.Quantity * il.UnitPrice) over(partition by ar.Name) as total_revenue
FROM `databird-2025.Chinook.InvoiceLine` il
JOIN `databird-2025.Chinook.Track` t 
  ON il.TrackId = t.TrackId
JOIN `Chinook.Album` al 
  ON al.AlbumId = t.AlbumId
JOIN `Chinook.Artist` ar 
  ON ar.ArtistId = al.ArtistId
ORDER BY 3 DESC;





-- 3. **Afficher le nombre de tracks par album**:

SELECT 
  al.Title, 
  COUNT(t.TrackId) AS NumberOfTracks
FROM `databird-2025.Chinook.Track` t
JOIN `databird-2025.Chinook.Album` al 
  ON t.AlbumId = al.AlbumId
GROUP BY al.Title;




-- 1. Rang des Albums par revenu total**:

-- Avec CTE (With)
With tab AS 
(
  SELECT 
    a.Title AS Album, 
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
  FROM `databird-2025.Chinook.InvoiceLine` il
  JOIN `databird-2025.Chinook.Track` t 
    ON il.TrackId = t.TrackId
  JOIN `databird-2025.Chinook.Album` a 
    ON t.AlbumId = a.AlbumId
  GROUP BY a.Title
)
SELECT 
  Album, 
  TotalRevenue, 
  RANK() OVER (ORDER BY TotalRevenue DESC) AS Rank
FROM tab t
ORDER BY 3;

-- Avec sous requête
SELECT Album, 
  TotalRevenue, 
  RANK() OVER (ORDER BY TotalRevenue DESC) AS Rank
FROM (
  SELECT a.Title AS Album, 
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
  FROM `databird-2025.Chinook.InvoiceLine` il
  JOIN `databird-2025.Chinook.Track` t 
    ON il.TrackId = t.TrackId
  JOIN `databird-2025.Chinook.Album` a 
    ON t.AlbumId = a.AlbumId
  GROUP BY a.Title
)
ORDER BY 3;


-- 2 . Analyser la Croissance Mensuelle des ventes 

WITH monthRevenue as
(
  SELECT
    DATE_TRUNC(InvoiceDate, MONTH) AS month,
    ROUND(SUM(Total),2) AS revenue,
  FROM `databird-2025.Chinook.Invoice`
  GROUP BY 1
),
MoM as (
  SELECT
      month,
      revenue,
      LAG(revenue) OVER (ORDER BY month ) as prevMonth,
    FROM monthRevenue
    ORDER BY 1
)
SELECT 
    *,
    (revenue - prevMonth) / prevMonth * 100 as monthGrowth
FROM MoM;


-- 3. Créer une vue pour les revenus par Artistes et par pays**:

CREATE OR REPLACE VIEW `databird-2025.Chinook.RevenueByCountryGenre` AS
SELECT 
    a.Name AS artiste, 
    BillingCountry,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
FROM `Chinook.Invoice` i
JOIN `Chinook.InvoiceLine` il 
  ON i.InvoiceId = il.InvoiceId
JOIN `Chinook.Track` t 
  ON il.TrackId = t.TrackId
JOIN `Chinook.Album` al 
  ON al.AlbumId = t.AlbumId
JOIN `Chinook.Artist` a 
  ON al.ArtistId = a.ArtistId
GROUP BY artiste, BillingCountry
ORDER BY 1, 3 DESC, 2;