-- WEEK 2 - ISESEISEV TÖÖ
-- UrbanStyle'i andmete kvaliteedi kontroll ja puhastamise harjutused
-- Selles failis on päringud, tulemused ja järeldused.
-- Algseid tabeleid ei muudeta ega kustutata.

-- 1. DUPLIKAATIDE TUVASTAMINE
-- 1.2 Concepts
-- 1.3 Harjutused 1A, 1B ja 1C

-- 2. NULL-VÄÄRTUSED
-- 2.2 Concepts
-- 2.3 Harjutused 2A, 2B ja 2C

-- 3. ANDMEFORMAADID JA TÜÜBIKONVERSIOONID
-- 3.2 Concepts
-- 3.3 Harjutused 3A, 3B ja 3C
-- 3.4 Conclusions

--WEEK 2
--1.2 Concepts: Duplikaatide tuvastamine samm-sammult 

--Samm 2: GROUP BY + HAVING COUNT(*) > 1
--Leia duplikaatsed sale_id väärtused
SELECT
  sale_id,                    -- Soovin näha müügi ID
  COUNT(*) AS koopiate_arv    -- Mitu korda sama müügi ID esineb? 
FROM sales                    -- Millisest tabelist andmeid võtame.
GROUP BY sale_id              -- Grupeerime kõik sama sale_id väärtusega read kokku
HAVING COUNT(*) > 1           --Näita ainult gruppe kus on rohkem kui üks rida
ORDER BY koopiate_arv DESC;   --Järjestame tulemused koopate arvu järgi kahanevalt. Suurim duplikaatide arv tuleb esimesena.

--Oluline: WHERE filtreerib RIDU enne grupeerimist, HAVING filtreerib GRUPPE pärast grupeerimist. Duplikaatide leidmisel kasuta alati HAVING.

------------

--Samm 3: ROW_NUMBER() — igale reale järjekorranumber
--Anna igale reale number oma grupi sees
SELECT
  sale_id,
  customer_id,
  total_price,
  sale_date,
  ROW_NUMBER() OVER (     --ROW_NUMBER annab järjekorra nr, OVER-määrab milliste reeglite järgi
    PARTITION BY sale_id  --Jagab read gruppidesse sama sale_id järgi (See jagab andmed gruppidesse, aga ei ühenda neid üheks reaks nagu GROUP BY)
    ORDER BY sale_date    --Järjestab iga grupi read kuuüeva järgi
    ) AS rn               --Annab uuele veeule nime rn (lühend sõnast row number ehk rea number)
FROM sales;

--TEAN ET:
--	rn = 1 on esimene (vanim) rida — see on "originaal"
--	rn > 1 on duplikaadid — need tuleks eemaldada

--Aga EI kustuta teist rida kohe ära!
--Miks? Sest enne peame kontrollima, kas see on päriselt duplikaat!!!

-------------------

--Samm 4. Tuvastamine vs eemaldamine

--KRIITILINE REEGEL: Sel nädalal sa TUVASTAD duplikaate, aga EI KUSTUTA neid!
--Andmete kustutamine (DELETE) on pöördumatu operatsioon. Shu tasemel on meie ülesanne:
--1. Tuvasta: mitu duplikaati on?
--2. Dokumenteeri: millised need on?
--3. Raporteeri: mis mõju neil on?

-------------------------------------------------------------

--WEEK 2, 1.3 HARJUTUSED

--Harjutus 1A: Shu – duplikaatide leidmine
--Eesmärk leida sales tabelist kõik korduvad sale_id väärtused
SELECT  
  sale_id,
  COUNT (*) AS koopiate_arv
FROM sales
GROUP BY sale_id 
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC
LIMIT 10;                   
--TULEMUSED:
--kõige rohkem duplikeeritud sale_id 4256 ja 2706, mõlemad esinevad 6 korda.


--Duplikaatide rahaline mõju
SELECT
    COUNT(*) AS erinevaid_duplikaatseid_sale_id
FROM (
    SELECT sale_id
    FROM sales
    GROUP BY sale_id
    HAVING COUNT(*) > 1
) AS duplikaadid;          --4013 erinevat sale_id esineb rohkem kui korra

--Duplikaatide mõju müüginumbritele
SELECT
  COUNT(*) AS ridu_kokku,
  COUNT(DISTINCT sale_id) AS unikaalseid,
  COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate,
  SUM(total_price) AS summa_duplikaatidega,
  (SELECT SUM(total_price)FROM (
    SELECT DISTINCT ON (sale_id) total_price
    FROM sales
    ORDER BY sale_id, id  --iga müügi väikseima id-ga rida = originaal
  ) unikaalsed) AS summa_ilm_duplikaatidega
FROM sales;

--TULEMUSED:
--Ridu kokku: 15234
--Unikaalseid: 10118
--Üleliigseid ridu: 5116
--Müügisumma duplikaatidega: 4374231.27 EUR
--Müügisumma ilma duplikaatideta: 2909177.98 EUR

--DUPLIKAATIDE RAHALINE MÕJU:
--4374231.27 - 2909177.98 = 1465053.29 EUR

--JÄRELDUS:
--Duplikaadid suurendavad müügisummat 1465053.29 euro võrra.

--!!!!!!Need kaks asja on erinevad:
--Mõiste	            Tulemus
--Duplikaatseid       sale_id väärtusi	4013
--Üleliigseid ridu	  5116

--Miks need erinevad on?
--Nt kui üks sale_id esineb 3 korda, siis:
--korduvate ID-de arv on 1;
--üleliigsete ridade arv on 2, sest ühe jätame alles

------------------------------------------------------

--Harjutus 1B: Ha – ROW_NUMBER() kasutamine
--Eesmärk kirjutada päring, mis kasutab ROW_NUMBER() funktsiooni, et nummerdada customers tabeli read email veeru järgi. Nii leiad kliendid, kellel on sama e-mail mitu korda.

--Valin vajalikud veerud
SELECT *
FROM (
    SELECT
      customer_id,
      first_name,
      last_name,
      email,
--nummerda kliendid e-posti aadressi järgi
      ROW_NUMBER() OVER (
        PARTITION BY email
        ORDER BY customer_id
    ) AS rn
--välistame NULL-väärtusega e-mailid. Oluline, sest puuduvid e-posti aadresse ei tohi käsitleda ühe ja sama e-mailina
  FROM customers
  WHERE email IS NOT NULL
) AS nummerdatud_kliendid
--Näita ainult duplikaate:
WHERE rn > 1
ORDER BY email, customer_id;
--TULEMUS:
--130 üleliigset kliendikirjete arvu

--Loendan erinevad korduvad e-mailid
SELECT
    COUNT(*) AS korduvaid_emaile
FROM (
    SELECT email
    FROM customers
    WHERE email IS NOT NULL
    GROUP BY email
    HAVING COUNT(*) > 1
) AS duplikaadid;
--TULEMUS:
--128 korduvaid e-maile

--Näitan korduvad e-mailid ja mitu korda korduvad
SELECT
    email,
    COUNT(*) AS esinemiste_arv
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY esinemiste_arv DESC;
--TULEMUS:
--2 emaili korduvad kolm korda, ülejäänud emailid korduvad kaks korda

--Kas nimed korduvad?
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    ROW_NUMBER() OVER (
        PARTITION BY email
        ORDER BY customer_id
    ) AS rn
FROM customers
WHERE email IN (
    SELECT email
    FROM customers
    WHERE email IS NOT NULL
    GROUP BY email
    HAVING COUNT(*) > 1
)
ORDER BY email, customer_id;


--TULEMUSED JA JÄRELDUSED

--TULEMUSED:
--1. Üleliigseid kliendikirjeid (rn > 1): 130
--2. Erinevaid korduvaid e-posti aadresse: 128
--3. Korduvate e-mailide esinemissagedus: 126 e-maili esineb kaks korda 2 e-maili esineb kolm korda
--4. Kas duplikaatsetel klientidel on erinevad nimed? Esineb erineva kirjapildi ja suur-väiketähtedega nimesid Nt Maris Paas ja MARIS Paas
--Sama e-mailiga klientide nimed vajavad kontrollimist

--JÄRELDUSED:
--Customers tabelis esineb 128 erinevat korduvat e-posti aadressi ning kokku 130 üleliigset kirjet
--See võib viidata klientide korduvale registreerimisele v andmete mitmekordsele importimisele
--Korduvad e-posti aadressid võivad põhjustada ebatäpsusi kliendiarvestuses ja kliendianalüüsis
--Enne andmete kustutamist tuleb kontrollida, kas tegemist on sama kliendiga ning millised kliendiandmed tuleb alles jätta
--Puhastamist selles ülesandes ei tehtud
--Tegemist oli duplikaatide tuvastamise ja analüüsiga

--------------------------------------

--HARJUTUS 1C: Products tabeli duplikaatide audit
--Kontrollin korduvaid tootenimesid

SELECT 
  product_name,
  COUNT(*) AS esinemiste_arv
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY esinemiste_arv DESC;
--TULEMUS:
--12 korduvat tootenime
--2 esinemist toote kohta

--Kontrollim korduvate nimedega toodete andmeid
SELECT
    product_id,
    product_name,
    category,
    subcategory,
    supplier,
    retail_price
FROM products
WHERE product_name IN (
    SELECT product_name
    FROM products
    GROUP BY product_name
    HAVING COUNT(*) > 1
)
ORDER BY product_name, product_id;
--TULEMUSED:
--12 Korduvat tootenime
--12 üleliigset rida
--24 korduvate nimedega rida
--5 võrreldud andmevälja 

--TULEMUSED JA JÄRELDUSED

--TULEMUSED:
--Leiti 12 erinevat korduvat tootenime
--Kõik korduvad tootenimed esinevad 2 korda
--Korduvate nimedega ridu kokku: 24
--Üleliigseid ridu: 12

--Kontrollisin ka järgmisi andmevälju: product_name, category, subcategory, supplier ja retail_price.
--Kõigi 12 tootepaari puhul olid võrreldud andmeväljade väärtused identsed.
--Erinev oli ainult product_id.

--JÄRELDUSED:
--Products tabelis esineb tõenäolisi korduvaid tooterekordeid
--See võib olla tingitud toodete mitmekordsest sisestamisest või korduvast andmete importimisest
--Korduvad tooterekordid võivad mõjutada laoseisu arvestust ja müügiandmete analüüsi
--Enne kustutamist tuleb kontrollida, kas mõlema product_id-ga on seotud müügitehinguid ja laokandeid
--Selles ülesandes andmeid ei kustutatud.
--Tegemist oli duplikaatide tuvastamise, kontrollimise ja dokumenteerimisega.

---------------------------------------------

--WEEK 2, 2.2 HARJUTUSED

--2.2 Concepts:NULL väärtused

--Samm 2: IS NULL ja IS NOT NULL
--Leia tellimused, kus klient on teadmata
SELECT 
  sale_id,
  customer_id,
  total_price
FROM sales
WHERE customer_id IS NULL;

--Leia kliendid, kellel ON e-mail olemas
SELECT 
  customer_id,
  first_name,
  email
FROM customers
WHERE email IS NOT NULL;

--Sammm 3: COALESCE () - asendusväärtus NULL-ile
--Asenda puuduv kliendi nimi vaikeväärtustega
SELECT
  customer_id,
  COALESCE(first_name, 'Tundmatu') AS eesnimi,
  COALESCE(email, 'puudub@urbanstyle.ee') AS email
FROM customers;

--Samm4: NULLIF() - vastupidine tööriist
--NULLIF (a, b): kui a=b, tagastab NULL: muidu tagastab a
SELECT NULLIF(100, 100); --Tulemus: NULL
SELECT NULLIF(100,200); --Tulmus: 100

--Muuda 0-hinnaga tooted NULL-iks (hind pole tegelikult 0, vaid puudub)
SELECT
  product_id,
  product_name,
  NULLIF(retail_price, 0) AS puhas_hind
FROM products;

--Samm5: NULL matemaatikas - NULL+5=NULL!
--Kõige ohtlikum NULL-i omadus: iga artimeetiline operatsioon NULL-iga annab NULL:
SELECT 100 + NULL; --Tulemus: NULL
SELECT NULL + 5; --Tulemus: NULL
SELECT SUM(total_price) FROM sales; -- SUM ignoreerib NULL-e! --4374231.27

--------

--2.3 Concrete Practice: NULL harjutused

--Harjutus 2A:Shu
--Leia UrbanStyle'i andmetest NULL väärtused
--NULL-ide ülevaade customers tabelis
SELECT
  COUNT(*) AS kliente_kokku
FROM customers;
--Vastus: Kliente kokku 3150

SELECT
  COUNT(first_name) AS eesnimi_olemas
FROM customers;
--Vastus: Eesnimi olemas 3150 inimesel

SELECT
  COUNT(*) - COUNT(first_name) AS eesnimi_puudub
FROM customers;
--Vastus: eesnimi puudu 0 inimesel

SELECT
  COUNT(email) AS email_olemas
FROM customers;
--Vastus: email olemas 2770 inimesel

SELECT
  COUNT(*) - COUNT(email) AS email_puudub
FROM customers;
--Vastus: email puudub 380 inimesel

SELECT
  COUNT(phone) AS telefon_olemas
FROM customers;
--Vastus: telefon olemas 3150 inimesel

SELECT
  COUNT(*) - COUNT(phone) AS telefon_puudub
FROM customers;
--Vastus: telefon puudu 0 inimesel

--Millised konkreetsed kliendid on puudulike andmetega?
SELECT 
  customer_id, 
  first_name, 
  last_name,
  email,
  city
FROM customers
WHERE first_name IS NULL
  OR last_name IS NULL
  OR email IS NULL
ORDER BY customer_id
LIMIT 15;

----------------

--2.3 Concrete Practice: NULL harjutused

--Harjutus 2B: Ha- COALESCE praktiline kasutamine
-- Ülesanne: Liis Koppel tahab näha kõiki kliente, aga tühjade nimede asemel peaks kuvama "Tundmatu klient". Kirjuta päring, mis kasutab COALESCE funktsiooni

--Harjutuse eesmärk on näidata klientide nime, e-posti ja telefoni asemel arusaadavat asendusteksti kui vastav väärtus on NULL
--COALESCE ei paranda ega muuda andmeid tabelis, see muudab ainult seda, kuidas päringu tulemus kuvatakse
SELECT
  customer_id,
  COALESCE(first_name, 'Tundmatu klient') AS eesnimi,
  COALESCE(last_name, '') AS perenimi,
  COALESCE(email, 'puudub') AS email,
  COALESCE(phone, 'puudub') AS telefon,
  city
FROM customers
WHERE first_name IS NULL
  OR last_name IS NULL
  OR email IS NULL
  OR phone IS NULL
ORDER BY customer_id;

--TULEMUSED: 
--Päring leidis 83 klienti kellel puudus vähemalt üks kontrollitud väärtustest
--COALESCE kuvab NULL'i asemel teksti 'puudub'
--See muudab ainult päringu tulemust mitte customers tabeli andmeid

-------------------------

--2.3 Concrete Practice: NULL harjutused

--Harjutus 2C: Rakendus- NULL'ide mõju arvutustele 
--Ülesanne: Kontrolli kas NULL-id mõjutavad sales tabeli arvutusi. Võrdle tulemusi!
--Selle harjutuse mõte on  kas NULL-id mõjutavad müügitabeli arvutusi. Võrrelda ridade arvu, olemasolevate total_price väärtuste arvu, puuduvaid summasid, kogusummat ja keskmist

--OLULINE: COUNT(*) loendab kõik read, aga COUNT(total_price) loendab ainult read kus total_price pole NULL. SUM() ja AVG() jätavad NULL-id automaatselt arvutusest välja
SELECT 
  COUNT(*) AS ridu,
  COUNT(total_price) AS summa_olemas,
  COUNT(*) - COUNT(total_price) AS summa_puudub,
  SUM(total_price) AS kogusumma,
  AVG(total_price) AS keskmine
FROM sales;
--TULEMUSED: 
--Sales tabelis on 10118 rida
--Kõigil ridadel on total_price olemas, NULL väärtusi on 0
--Kogusumma on 2909177,98 ja keskmine 287,53
--SUM() ja AVG() ei jäta selle veeru puhul ühtegi rida NULL'i tõttu arvestusest välja
--Praeguses sales tabelis on 10118 rida, 1A harjutuses oli sales tabelis 15234 rida (Need tulemused näitavad, et tabeli suurus on nende päringute vahel erinev)

-----------------------------------------

--WEEK 2. Osa 3: Andmeformaadid ja Tüübikonversioonid

--3.1 Connection: Kuupäevaformaatide segadus
--KÜSIMUS: Kui andmebaasis on sadu selliseid kuupäevi, kuidas sa tead, milline formaat on õige? Vaatan andmete dokumentatsiooni või andmete päritolu

--3.2 Concepts: Andmeformaadid ja tüübikonversioonid 
--SAMM 1: Andmetüübid SQL'is. Iga veerg SQL'is on kindlat tüüpi:

--TEXT / VARCHAR: tekst
SELECT 'Tallinn' AS linn, 'Jaan Kask' AS nimi;

--INTEGER: täisarv
SELECT 42 AS arv, 1000 AS suurem_arv, -5 AS negatiivne_arv;

--NUMERIC / DECIMAL: kümnendmurd
SELECT 125.50 AS hind, 3.14 AS komakohtadega_arv;

--DATE: kuupäev
SELECT '2024-01-15'::DATE AS kuupaev;

--TIMESTAMP: kuupäev ja kellaaeg
SELECT '2024-01-15 14:30:00'::TIMESTAMP AS kuupaev_ja_kellaaeg;

--BOOLEAN: tõene/väär
SELECT TRUE AS toene, FALSE AS vaar;

------

--SAMM 2: CAST ja :: - tüübikonversioon.
--OLULINE: tekst peab olema sihtandmetüübi jaoks sobivas formaadis. Nt see annab vea sest sõna pole number ei saa arvuks muuta:

--CAST: standardne SQL'i süntaks:
SELECT CAST('125.50' AS NUMERIC);
--PostrSQL'I lühike süntaks:
SELECT '125.50' :: NUMERIC;
--TULEMUS: Mõlemal juhul muudetakse tekst '125.50' arvuks 125.50

--Kuupäeva saab samamoodi tekstist kuupäevaks muuta:
--CAST: standardne SQL'i süntaks:
SELECT CAST('2024-01-15' AS DATE);
--PostrSQL'I lühike süntaks:
SELECT '2024-01-15' :: DATE;

--Kui formaat ei sobi, annab CAST veateate:
SELECT CAST ('pole number' AS NUMERIC); --VIGA!

-------

--SAMM3: Kuupäevafunktsioonid - TO_CHAR() ja TO_DATE()
--Need funktsioonid teevad eri asju:

--Kuupäev erinevates formaatides:
-- TO_CHAR() muudab kuupäeva tekstiks soovitud kujul:
SELECT
  sale_date,
  TO_CHAR(sale_date, 'DD.MM.YYYY') AS eesti_formaat,
  TO_CHAR(sale_date, 'YYYY-MM-DD') AS iso_formaat,
  TO_CHAR(sale_date, 'DD. Month YYYY') AS pikk_formaat
FROM sales
LIMIT 5;
--TULEMUS: 2024-03-15. Formaadi määramine on tähtis: 15/03/2024 tuleb tõlgendada päev/kuu/aasta järjekorras!

-- TO_DATE() muudab kuupäeva sisaldava teksti kuupäevaks kui ütled ette mis formaadis tekst on
SELECT TO_DATE ('15/03/2024', 'DD/MM/YYYY');    --Tulemus: 2024-03-15
SELECT TO_DATE('2024-01-15', 'YYYY-MM-DD');     --Tulemus:2024-01-15

-------

--SAMM 4: Tekstifunktsioonid - TRIM(), UPPER(), LOWER()
--Need näitavad teisendatud tulemust kuid ei muuda algseid väärtusi tabelis

--TRIM() eemaldab tühikud teksti algusest ja lõpust: 
SELECT TRIM('tallinn');     --Tulemus: 'tallinn'
SELECT TRIM(' ');           --Tulemus: '' (tühi string)

--UPPER() ja LOWER() muudavad teksti suur- või väiketähtedeks:
SELECT UPPER('tallinn');   --Tulemus: 'TALLINN'
SELECT LOWER('TALLINN');    --Tulemus: 'tallinn'

--INITCAP() muudab iga sõna algustähe suureks:
SELECT INITCAP('tallinn');   --Tulemus: 'Tallinn'

--Praktiline kasutus- linnade ühtlustamine:
--Leia kõik unikaalsed linnade nimed:
SELECT DISTINCT city   --DISTINCT näitab iga erinevat väärtust ainult ühe korra
FROM customers   
ORDER BY city;         --ORDER BY city järjestab linnanimed tähestiku järgi
--Tulemus: 12 linna nime

--Ühtlusta: eemalda tühikud, muuda algustäht suureks
SELECT DISTINCT
  city AS originaal,
  TRIM(city) AS trimitud,
  UPPER(TRIM(city)) AS suurtahtedega,
  INITCAP(TRIM (city)) AS esitaht_suur
FROM customers
WHERE city IS NOT NULL
order by CITY;
--Tulemus: UPPER() muutis linnanimed suurtähtedeks ja INITCAP() säilitas algustähe suure ning ülejäänud tähed väikestena

----------

--3.3 Concrete Practice: Andmeformaatide harjutused 

--Harjutus 3A: Shu
-- Kuupäevade formateerimine UrbanStyle'i andmetes
--Eesmärk-  kuidas TO_CHAR() abil saab sama kuupäeva esitada eri kujul ning kuidas leida kuupäevast nädalapäev ja kvartal
SELECT
    sale_id,
    sale_date,
    TO_CHAR(sale_date, 'DD.MM.YYYY') AS eesti_kuupaev,
    TO_CHAR(sale_date, 'Day') AS nadalapäev,
    TO_CHAR(sale_date, 'YYYY-"Q"Q') AS kvartal,
    EXTRACT(DOW FROM sale_date) AS paev_nr
FROM sales
ORDER BY sale_date DESC
LIMIT 10;
--Küsimused: 
--Mis formaadis on sale_date vaikimisi salvestatud?  YYYY-MM-DD HH:MM:SS ehk kuupäeva ja kellaajana.
--Milline päev oli viimane tellimus?                 Pühapäev, 28.06.2026
--Millises kvartalis oli kõige viimane tellimus?     2026. aasta II kvartalis (2026-Q2)

--Linnade ühtlustamise diagnostika
SELECT
  city AS originaal,
  TRIM(city) AS trimitud,
  INITCAP (TRIM(city)) AS puhastatud,
  COUNT(*) AS kliente
FROM customers
GROUP BY city
ORDER BY city;
--Tulemus: 
--Mitu erinevat kirjaviisi on samal linnal?   Tulemuse põhjal ei esinenud samal linnal mitut erinevat kirjaviisi. 12 erinevat linnanime ja nende algne ja puhastatud kirjapilt on samad.

------------------------------------

--Harjutus 3B: Ha andmete puhastamine
--Ülesanne: Kirjuta päring, mis näitab customers tabeli linnade "puhastatud" versiooni koos statistikaga. Grupeeri puhastatud linnade kaupa.
SELECT
  INITCAP(TRIM(city)) AS puhastatud_linn,    --eemaldab linna nime algusest ja lõpust tühikud
  COUNT(*) AS kliente_kokku,                 --loendab mitu klienti selles linnagrupis on
  COUNT(DISTINCT city) AS algseid_kirjaviise --loendabmitu eri algset kirjapilti puhastatud linna alla koondus
FROM customers                               
WHERE city IS NOT NULL                       --jätab välja read, kus linn puudub
GROUP BY INITCAP(TRIM(city))                 --koondab sama puhastatud nimega kirjed ühte gruppi
ORDER BY kliente_kokku DESC;                 --järjestab linnad klientide arvu järgi (suurem-väiksem)
--Küsimused:
--Mitu unikaalset "puhastatud" linna sa näed?                      12
--Kas mõnel linnal on rohkem kui üks algne kirjaviis?              Ei
--Miks GROUP BY puhastatud versiooni järgi annab õigema tulemuse?  See koondab sama linna eri kirjapildid üheks grupiks, nii et linnade arv ja klientide arv ei lähe erinevuste tõttu lahku.


---------------------------------------------------

--Harjutus 3C: Rakendus - tüübikonversiooni probleemid 
--Ülesanne: Kontrollin products tabeli retail_price väärtusi
--Otsin puuduvaid, null- ja negatiivseid hindu
--See päring ei kasuta CAST-i, see kontrollib hinnaväärtusi
SELECT 
  product_id,
  product_name,
  retail_price,
  CASE                                                 --kontrollib tingimusi järjekorras ja määrab igale tulemuses olevale tootele staatuse
    WHEN retail_price IS NULL THEN 'NULL'              --kontrollib kas hind puudub
    WHEN retail_price = 0 THEN 'NULL (0 = puudub?)'    --kontrollib kas hind on null
    WHEN retail_price < 0 THEN 'NEGATIVE!'             --kontrollib kas hind on negatiivne
    ELSE 'OK'                                          --juhuks kui ükski eelnev tingimus ei kehti. Selle päringu WHERE tõttu ei tohiks OK ridu tavaliselt tulemusse sattuda
  END AS hinna_staatus
FROM products
WHERE retail_price IS NULL OR retail_price <= 0        --jätab tulemusse ainult tooted mille hind on NULL, 0 või negatiivne
ORDER BY retail_price;
--TULEMUSED:
--Päring leidis 0 toodet mille retail_price on NULL, 0 või negatiivne
--Päring kontrollis hindade väärtusi kuid ei kasutanud CAST'i ega kontrollinud tekstiväärtuste teisendamist


-------------------

--3.4 Conclusions: Andmeformaatide kokkuvõte 

--Põhijäreldus: Andmete tüübikonversioon (CAST/::), kuupäevafunktsioonid (TO_CHAR, TO_DATE) ja tekstifunktsioonid (TRIM, UPPER, LOWER, INITCAP) on hädavajalikud tööriistad andmete ühtlustamiseks. Ilma nendeta käsitleb SQL "Tallinn" ja "tallinn" kahe erineva väärtusena.
