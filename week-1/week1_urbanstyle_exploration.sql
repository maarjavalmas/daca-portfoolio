-- =====================================================
-- NÄDAL 1: SQL PÕHITÕED
-- Projekt: UrbanStyle
-- Teema: SELECT, FROM, WHERE, DISTINCT, COUNT
-- =====================================================

-- Selle nädala eesmärk:
-- Õppida SQL-i abil andmeid andmebaasist otsima,
-- filtreerima, sorteerima ja loendama.


-- =====================================================
-- OSA 1: SELECT JA FROM
-- =====================================================

-- SAMM 1: Tahan näha oma müügitabeli ridu ja veerge.
-- SELECT - vali andmed
-- * - näita kõiki veerge
-- FROM sales - võta andmed tabelist sales
-- ; - päringu lõpp
SELECT *
FROM sales;

-- SAMM 2: Konkreetsete veergude valimine
-- VALIN AINULT NEED VEERUD, MIDA VAJAN
-- SELECT - määran, milliseid veerge tahan näha
-- FROM sales - võtan andmed müügitabelist
SELECT customer_id, total_price, sale_date
FROM sales;

-- SAMM 3: AS - veergude ümbernimetamine
-- AS annab veerule uue ajutise nime.
-- AS ei muuda andmebaasi ega algset veerunime.
-- Muutub ainult päringu tulemuses kuvatav pealkiri.
SELECT 
    customer_id AS klient,
    total_price AS summa,
    sale_date AS kuupäev
FROM sales;

-- SAMM 4: LIMIT - piira tulemuste arvu
-- LIMIT ütleb, mitu rida tahan tulemuses näha.
-- Näiteks LIMIT 10 näitab ainult 10 rida.
SELECT customer_id, total_price
FROM sales
LIMIT 10;

-- SAMM 5: ORDER BY - tulemuste sorteerimine
-- ORDER BY sorteerib tulemused valitud veeru järgi.
-- ASC (vaikimisi) - väiksemast suuremani ehk kasvav järjestus.
SELECT customer_id, total_price
FROM sales
ORDER BY total_price ASC;
-- DESC - suuremast väiksemani ehk kahanev järjestus.
SELECT customer_id, total_price
FROM sales
ORDER BY total_price DESC;


-- 1.3 Concrete Practice: SELECT harjutused
-- HARJUTUS 1A: Shu - kopeeri ja käivita
-- Päring 1: Näitan müügitabeli esimesed 5 rida.
SELECT *
FROM sales
LIMIT 5;

-- Päring 2: Valin konkreetsed veerud.
SELECT sale_id, customer_id, total_price, sale_date
FROM sales
LIMIT 10;

-- Päring 3: Sorteerin müügid suurima summa järgi ja näitan ainult 5 esimest tulemust.
SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price DESC
LIMIT 5;


-- HARJUTUS 1B: Shu/Ha - muuda malli 
-- Ülesanne: Leian hoopis 5 kõige väiksema summaga müüki.
SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price ASC
LIMIT 5;


-- HARJUTUS 1C: Rakendus - vali ise veerud
-- Ülesanne: Näitan kliendi ID-d, müügikuupäeva ja summat.
-- Sorteerin kuupäeva järgi, uuemad müügid enne.
-- LIMIT 20 näitab ainult 20 rida.
SELECT 
    customer_id,
    sale_date,
    total_price
FROM sales
ORDER BY sale_date DESC
LIMIT 20;




-- =====================================================
-- OSA 2: WHERE - ANDMETE FILTREERIMINE
-- =====================================================

-- 2.2 Concepts: WHERE samm-sammult

-- SELECT - määrab, milliseid veerge tahan näha
-- FROM - määrab, millisest tabelist andmed tulevad
-- WHERE - määrab, millised read tahan alles jätta
-- Väga oluline reegel: WHERE tuleb alati pärast FROM-i.


-- SAMM 1: Võrdlusoperaatorid
-- =   võrdne
-- !=  ei ole võrdne
-- >   suurem kui
-- <   väiksem kui
-- >=  suurem või võrdne
-- <=  väiksem või võrdne

-- Näide: tahan näha müüke, mille summa on üle 100 euro.
SELECT sale_id, total_price
FROM sales
WHERE total_price > 100
ORDER BY total_price DESC;


-- SAMM 2: BETWEEN, IN ja LIKE

-- BETWEEN - otsin väärtusi kindlast vahemikust.
-- Näide: müügid vahemikus 100-500 eurot.
SELECT sale_id, total_price
FROM sales
WHERE total_price BETWEEN 100 AND 500;


-- IN - otsin mitut konkreetset väärtust korraga.
-- Näide: müügid Tallinna või Tartu kauplusest.
SELECT sale_id, total_price
FROM sales
WHERE store_location IN ('Tallinn', 'Tartu');


-- LIKE - otsin teksti kindla mustri järgi.
-- K% - algab K-tähega.
-- %son - lõpeb son-iga.
-- %anna% - sisaldab teksti anna.
-- Näide: kliendid, kelle eesnimi algab K-tähega.
SELECT customer_id, first_name, last_name
FROM customers
WHERE first_name LIKE 'K%';


-- SAMM 3: AND ja OR - mitu tingimust koos

-- AND - mõlemad tingimused peavad olema tõesed.
-- Näide: suured müügid Tallinnast.
SELECT sale_id, total_price, channel
FROM sales
WHERE total_price > 500
  AND store_location = 'Tallinn';


-- OR - vähemalt üks tingimus peab olema tõene.
-- Näide: müügid, mis on kas väga suured või väga väikesed.
SELECT sale_id, total_price
FROM sales
WHERE total_price > 500
   OR total_price < 10;


-- OLULINE: AND ja OR kombineerides kasutan sulge, et tingimuste järjekord oleks selge.
SELECT sale_id, total_price, channel
FROM sales
WHERE (store_location = 'Tallinn' OR store_location = 'Tartu')
  AND total_price > 100;


-- SQL PÄRINGU JÄRJEKORD:
-- SELECT   - mida näidata?
-- FROM     - millisest tabelist?
-- WHERE    - milliseid ridu jätta?
-- ORDER BY - kuidas sorteerida?
-- LIMIT    - mitu rida näidata?


-- =====================================================
-- 2.3 Concrete Practice: WHERE harjutused
-- =====================================================

-- HARJUTUS 2A: Shu - kopeeri ja käivita
-- Päring 1: Suured tellimused.
-- Näitan tellimusi, mille summa on üle 500 euro.
SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC;

-- Päring 2: Kindla perioodi müügid.
-- Näitan müüke, mis toimusid 2024. aasta esimeses kvartalis.
SELECT sale_id, sale_date, total_price
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY sale_date;

-- Päring 3: NULL väärtuste otsimine.
-- Leian tellimused, millel puudub kliendi ID.
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;


-- HARJUTUS 2B: Shu/Ha - kombineeri tingimusi
-- Ülesanne: Toomas tahab näha tellimusi, mille summa on üle 200 euro ja mis on tehtud 2024. aastal.
SELECT total_price, sale_date
FROM sales
WHERE total_price > 200
  AND sale_date >= '2024-01-01'
  AND sale_date < '2025-01-01'
ORDER BY total_price DESC;

-- Lisaülesanne: Lisan kolmanda tingimuse. Näitan ainult online-kanali tellimusi.
SELECT total_price, sale_date, channel
FROM sales
WHERE total_price > 200
  AND sale_date >= '2024-01-01'
  AND sale_date < '2025-01-01'
  AND channel = 'online'
ORDER BY total_price DESC;

-- HARJUTUS 2C: Rakendus - Toomase küsimus
-- Ülesanne: Toomas tahab näha tellimusi, kus summa on 0 või väiksem VÕI kliendi ID puudub.
SELECT sale_id, total_price, customer_id, sale_date
FROM sales
WHERE total_price <= 0
   OR customer_id IS NULL
ORDER BY total_price;




-- =====================================================
-- OSA 3: DISTINCT JA COUNT
-- =====================================================

-- 3.2 Concepts: DISTINCT ja COUNT samm-sammult
-- DISTINCT - eemaldab tulemusest korduvad väärtused.
-- COUNT(*) - loendab kõik read.
-- COUNT(veerg) - loendab ainult täidetud väärtused.
-- COUNT(DISTINCT veerg) - loendab ainult erinevad väärtused.

-- SAMM 1: DISTINCT - ainult unikaalsed väärtused
-- Näitan kõiki müügikanaleid (ka korduvaid).
SELECT channel
FROM sales;

-- Näitan ainult erinevaid müügikanaleid.
SELECT DISTINCT channel
FROM sales;

-- Näitan erinevaid kanali ja maksemeetodi kombinatsioone.
SELECT DISTINCT channel, payment_method
FROM sales;


-- SAMM 2: COUNT - ridade loendamine
-- COUNT(*) - loendab kõik read, sealhulgas NULL-väärtused.
-- COUNT(veerg) - loendab ainult täidetud väärtused.
-- COUNT(DISTINCT veerg) - loendab erinevad täidetud väärtused.

-- Mitu rida on tabelis kokku?
SELECT COUNT(*) AS ridade_arv
FROM sales;

-- Mitu rida omab customer_id väärtust (mitte NULL)?
SELECT COUNT(customer_id) AS klientidega_tellimused
FROM sales;

-- Mitu ERINEVAT klienti on tellimusi teinud?
SELECT COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;

-- SAMM 3: NULL-ide loendamine
-- Kui palju customer_id väärtusi puudub?
-- Selleks lahutan täidetud väärtuste arvu kõikide ridade arvust.
SELECT
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid
FROM sales;


-- SAMM 4: Duplikaatide tuvastamine
-- Toomase meetod duplikaatide leidmiseks.
-- SAMM A: Mitu rida on kokku?
SELECT COUNT(*) AS kokku
FROM sales;

-- SAMM B: Mitu unikaalset sale_id-d on?
SELECT COUNT(DISTINCT sale_id) AS unikaalseid
FROM sales;

-- Kui kõikide ridade arv on suurem kui unikaalsete ID-de arv,
-- siis on tabelis korduvaid sale_id väärtusi.


-- =====================================================
-- 3.3 Concrete Practice: DISTINCT ja COUNT harjutused
-- =====================================================

-- HARJUTUS 3A: Shu - kopeeri ja käivita

-- Päring 1: Tabeli üldpilt.
-- Loendan kõik read, klientidega read, puuduva kliendi ID-ga read ja unikaalsed kliendid.
SELECT
    COUNT(*) AS ridade_arv,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puudub_klient,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;

-- Päring 2: Unikaalsed kanalid.
SELECT DISTINCT channel
FROM sales
ORDER BY channel;

-- Päring 3: Unikaalsed maksemeetodid.
SELECT DISTINCT payment_method
FROM sales
ORDER BY payment_method;


-- HARJUTUS 3B: Shu/Ha - Toomase duplikaatide uurimine
-- SAMM 1: Leian kõigi ridade arvu.
SELECT COUNT(*) AS kokku
FROM sales;

-- SAMM 2: Leian unikaalsete sale_id-de arvu.
SELECT COUNT(DISTINCT sale_id) AS unikaalseid
FROM sales;

-- SAMM 3: Arvutan duplikaatide arvu.
SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaadid
FROM sales;

-- Lisaülesanne: Uurin, kas customers tabelis esineb korduvaid e-posti aadresse.
SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT email) AS unikaalseid_emaile,
    COUNT(*) - COUNT(DISTINCT email) AS duplikaatseid
FROM customers;


-- HARJUTUS 3C: Rakendus - uurimisraport
-- Ülesanne: Uurin products tabelit.
-- Kõigepealt vaatan, millised veerud tabelis olemas on.
SELECT *
FROM products
LIMIT 1;

-- Päring: Toodete koguarv, erinevate kategooriate arv
-- ja puuduvate hindade arv.
-- Kasutan retail_price veergu, sest see on toodete müügihind.
SELECT
    COUNT(*) AS toodete_arv,
    COUNT(DISTINCT category) AS kategooriad,
    COUNT(*) - COUNT(retail_price) AS puuduvaid_hindu
FROM products;




-- =====================================================
-- SÜNTEES: TOOMAS KASKI RAPORT
-- =====================================================

-- Eesmärk: Vastan Toomase küsimustele UrbanStyle'i
-- müügiandmete kohta, kasutades õpitud SQL-käske.


-- PÄRING 1: Duplikaatide arv
-- Loendan kõik müügitabeli read.
-- Seejärel loendan unikaalsed sale_id väärtused.
-- Nende vahe näitab korduvate ridade arvu.
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales;


-- PÄRING 2: Puuduvad kliendi ID-d
-- Leian, mitu müügitabeli rida on ilma kliendi ID-ta.
-- IS NULL otsib puuduvaid väärtusi.
SELECT
    COUNT(*) AS puuduvaid_kliente
FROM sales
WHERE customer_id IS NULL;


-- PÄRING 3: 10 suurimat müüki
-- Näitan müügi ID-d, kliendi ID-d ja müügisummat.
-- DESC järjestab summad suurimast väikseimani.
-- LIMIT 10 näitab ainult 10 kõige suuremat müüki.
SELECT
    sale_id,
    customer_id,
    total_price
FROM sales
ORDER BY total_price DESC
LIMIT 10;


-- PÄRING 4: 10 väikseimat ja kahtlased müügid
-- Leian müügid, mille summa on 0 või väiksem.
-- ASC järjestab summad väikseimast suurimani.
-- LIMIT 10 näitab kuni 10 sellist müüki.
SELECT
    sale_id,
    customer_id,
    total_price
FROM sales
WHERE total_price <= 0
ORDER BY total_price ASC
LIMIT 10;
