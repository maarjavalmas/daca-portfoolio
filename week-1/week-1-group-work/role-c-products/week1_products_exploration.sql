--ROLL C:TOOTEANDMED
--ÜLESANNE: Toomas tahab teada, millised tooted on UrbanStyle'i sortimendis. Uuri products tabelit: mitu toodet on? Millised kategooriad? Milline on hinnavahemik? Kas on puuduvaid andmeid?

--TOODETE KOGUARV
--Mitu toodet on kokku?
SELECT COUNT(*) AS toodete_arv
FROM products;

--TABELI SISU
--Millised veerud ja andmed tabelis on? 
SELECT * FROM products 
LIMIT 10;

--TOOTEKATEGOORIAD
--Kõik unikaalsed tootekategooriad
SELECT DISTINCT category
FROM products;

--HINNAVAHEMIK
--10 kallimat toodet
SELECT product_name, category, retail_price
FROM products
ORDER BY retail_price DESC
LIMIT 10;
--10 odavamat toodet
SELECT product_name, category, retail_price
FROM products
ORDER BY retail_price
LIMIT 10;

--FILTREERIMINE KATEGOORIA JÄRGI
--Mitu toodet on igas kategoorias?
SELECT
    category,
    COUNT(*) AS toodete_arv
FROM products
GROUP BY category
ORDER BY toodete_arv DESC;
-- Filtreerime naisteriiete kategooria tooted
SELECT *
FROM products
WHERE category = 'naiste_riided'
ORDER BY retail_price DESC;

--PUUDUVAD VÄÄRTUSED
--Puuduvad hinnad
SELECT COUNT(*) - COUNT(retail_price) AS puuduvad_hinnad
FROM products;
--Puuduvad kategooriaad
SELECT COUNT(*) - COUNT(category) AS puuduvad_kategooriad
FROM products;
--Puuduvad ökosertifikaadi andmed
SELECT
    COUNT(*) - COUNT(eco_certified) AS puuduvad_sertifikaadid
FROM products;

--Korduvate tootenimede kontroll
-- Otsime korduvaid tootenimesid
SELECT
    product_name,
    COUNT(*) AS korduste_arv
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY korduste_arv DESC;

-- Toodete arv ja hinnavahemik kategooriate kaupa (lisaülesanne)
SELECT
    category,
    COUNT(*) AS toodete_arv,
    MIN(retail_price) AS min_hind,
    MAX(retail_price) AS max_hind
FROM products
GROUP BY category
ORDER BY max_hind DESC;

-- Üle 50 euro maksvad naisteriided (lisaülesanne)
SELECT *
FROM products
WHERE retail_price > 50
  AND category = 'naiste_riided'
ORDER BY retail_price DESC;
