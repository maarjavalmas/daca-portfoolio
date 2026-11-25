--GRUPITÖÖ A: MÜÜKIDE JA KLIENTIDE ÜHENDAMINE

--ÜLESANNE 1: Müükide ja klientide ühendamine
--Eesmärk: Millised kliendid on oste teinud ja vaadata nende ostude põhiandmeid
--Ühendan sales- ja customers-tabelid customer_id abil
--INNER JOIN seob müügi kliendiga customer_id abil
--Nii saan iga müügi juurde lisada kliendi nime, e-posti aadressi ja linna
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    s.sale_id,
    s.sale_date,
    s.total_price
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
LIMIT 20; 



--ÜLESANNE 2: TOP 10 klienti kogumüügi järgi
--Eesmärk: Leida kümme klienti, kelle ostude kogusumma on suurim
--COUNT loendab iga kliendi ostud
--SUM liidab kokku kliendi müügisummad
--GROUP BY koondab iga kliendi üheks reaks
--ORDER BY järjestab kliendid kogumüügi järgi kahanevalt

SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    COUNT(DISTINCT s.sale_id) AS ostude_arv,
    SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY kogumüük DESC
LIMIT 10; --Tulemus: suurima kogumüügiga klient TOP 10 seas oli Tiina Pärn (73 ostu ja 27668,02 eur.  Teine oli Priit Rand (26286,10 eur) ja kolmas Kevin Org (23467,13 eur)



--ÜLESANNE 3: Müügiülevaade linnade kaupa
--Eesmärk: Võrrelda linnu klientide arvu, ostude arvu ja kogumüügi põhjal
--COUNT(DISTINCT c.customer_id) loendab igas linnas erinvad kliendid
--COUNT(s.sale_id) loendab müügid 
--SUM(s.total_price) liidab müügisummad
--GROUP BY koondab tulemused linna kaupa
--ORDER BY järjestab linnad kogumüügi järgisuurimast väiksemani
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS kliente,
    COUNT(s.sale_id) AS oste,
    SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c
    ON s.customer_id = c.customer_id
GROUP BY c.city
ORDER BY kogumüük DESC;   --Tulemus: enim müüke ja suurim kogumüük oli Tallinnas.
--Tallinn: 1007 klienti, 3601 ostu, 1006252,88 eur



--ÜLESANNE4: Müük lojaalsustaseme järgi
--Eesmärk: Võrrlda klientide arvu ja kogumüüki lojaalsustaseme (loyalty_tier) kaupa
--COUNT(DISTINCT c.customer_id) loendab iga kliendi ainult ühe korra
--SUM(s.total_price) liidab kokku müügisummad
--GROUP BY koondab tulemused lojaalsustaseme kaupa
--ORDER BY järjestab tasemed kogumüügi järgi suurimast väiksemani
SELECT
  c.loyalty_tier,
  COUNT(DISTINCT c.customer_id) AS kliente,
  SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c
  ON s.customer_id = c.customer_id
GROUP BY c.loyalty_tier
ORDER BY kogumüük DESC; --Tulemuse järgi on kõige suurem kogumüük klientidel, kelle loyalty_tier on NULL (kokku 1071805,32 eur)



--ÜLESANNE 5: Puuduva lojaalsustaseme kontroll
--Eesmärk: Kontrollida, kui paljudel klientidel puudub lojaalsustase (loyalty_tier)
--COUNT(*) loendab kõik customers-tabeli kliendid
--COUNT(*) FILTER (WHERE loyalty_tier IS NULL) loendab ainult kliendid kelle lojaalsustase puudub, nii saan teada, kas NULL-rühm on väike või suur
SELECT
  COUNT(*) AS kliente_kokku,
  COUNT(*) FILTER (
    WHERE loyalty_tier IS NULL
  ) AS puuduva_lojaalsustasemega_kliente
FROM customers; 
--Tulemus: 3150 klienti kokku, neist 1260'l puudus lojaalsustase, ehk 40% klientidest



--EDASIJÕUDNUTE ÜLESANNE 1: Üle keskmise kogumüügiga kliendid
--Eesmärk: Leida kliendid kelle kogumüük on suurem kui klientide keskmine kogumüük
--Sisemine päring arvutab iga kliendi kogumüügi
--Järgmine päring arvutab nende kogumüükide keskmise
--HAVING jätab alles kliendid, kelle kogumüük ületab keskmist
--ORDER BY järjestab tulemuse kogumüügi järgi suurimast väiksemani
SELECT
  c.first_name  || ' ' || c.last_name AS klient,
  SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c
  ON s.customer_id = c.customer_id
GROUP BY 
  c.customer_id,
  c.first_name,
  c.last_name
HAVING SUM(s.total_price) > (
  SELECT AVG(kliendi_müük)
  FROM (
    SELECT sum(total_price) AS kliendi_müük
    FROM sales
    GROUP BY customer_id
  ) AS keskmised
)
ORDER BY kogumüük DESC;


--EDASIJÕUDNUTE KÜSIMUS: Mitu protsenti ostnud klientidest kulutab rohkem kui keskmine klient?
--Eesmärk: Arvutada, mitu protsenti ostu teinud klientidest kulutab rohkem kui kliendi keskmine kogumüük
--Ajutine tulemustabel 1 - ''klientide_myygid'' arvutab iga kliendi kogumüügi
--Ajutine tulemustabel 2 - ''keskmine'' leiab nende kogumüükide keskmise
--Siis loendan keskmisest suurema kogumüügiga kliendid ning jagan nende arvu kõigi ostu teinud klientide arvuga
--Korrutan sajaga, et saada protsent
WITH klientide_myygid AS (      --Ajutine tulemustabel 1
    SELECT
        customer_id,
        SUM(total_price) AS kogumüük
    FROM sales
    GROUP BY customer_id
),
keskmine AS (      --Ajutine tulemustabel 2
    SELECT AVG(kogumüük) AS keskmine_kogumüük
    FROM klientide_myygid
)
SELECT
    COUNT(*) FILTER (
        WHERE km.kogumüük > k.keskmine_kogumüük
    ) AS ule_keskmise_kliente,
    COUNT(*) AS ostnud_kliente,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE km.kogumüük > k.keskmine_kogumüük
        ) / COUNT(*),
        2
    ) AS ule_keskmise_klientide_protsent
FROM klientide_myygid km
CROSS JOIN keskmine k;
--Tulemus: 763 klienti kulutasid rohkem kui klientide keskmine kogumüük. Analüüsis oli 2552 ostnud klienti. Üle keskmise kulutajate osakaal on 29.9%

--KOKKUVÕTE
--Vaatasin UrbanStyle’i müüke ja kliente. Kõige rohkem oli müüki Tallinnas kus tehti 3601 ostu ja müügisumma oli kokku 1006252,88 eurot. TOP 10 klientidest oli kõige suurema kogumüügiga Tiina Pärn, kelle ostude summa oli 27668,02 eurot. Lojaalsustasemetest oli suurim müügisumma silver-klientidel, kui puuduva tasemega kliendid välja jätta. Üle keskmise kulutas 763 klienti ehk 29,90% ostnud klientidest.


--1260 klienti 3150-st: st kui paljudel kõigist klientidest puudub lojaalsustase. See on 40%.
--763 klienti 2552-st: st, kui paljud ostnud kliendid kulutasid rohkem kui ostnud klientide keskmine. See on 29,90%.


--Äriline järeldus: Üle keskmise kulutas 763 klienti ehk 29.90% ostnud klientidest, st ülejäänud 70,10% ostnud klientidest kulutasid keskmisest vähem. UrbanStyle 
