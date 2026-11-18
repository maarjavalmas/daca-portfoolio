-ROLL D: RISTVALIDEERIMINE JA KVALITEEDIKONTROLL

--Ristvalideerimine (Cross-validation) tähendab siin seda, et kontrollime ühe tabeli väärtusi teise tabeli vastu.
--Nt:
-- sales.customer_id peab leiduma tabelis customers.
-- sales.product_id peab leiduma tabelis products.



--SAMM 1: ORBID KLIENDID. Kas kõik müügis viidatud kliendid eksisteerivad?
-- Kas on customer_id, mida pole customers tabelis?
SELECT COUNT(*) AS orb_klient
FROM sales
WHERE customer_id IS NOT NULL
  AND customer_id NOT IN (
    SELECT customer_id 
    FROM customers 
    WHERE customer_id IS NOT NULL
    );
--TULEMUSED:
--0 müügikirjet, mis viitaksid olematule kliendile
--OLULINE: see ei tõesta et kõik kliendiandmed on korras. Kontrollisin ainult seda kas müügid viitavad olemasolevatele klientidele



--SAMM 2: ORBID TOOTED. Kontrollin kas kõik müügis viidatud tooted eksisteerivad:
--Kas on product_id, mida pole products tabelis? 
SELECT
  COUNT(*) AS orb_toode
FROM sales
WHERE product_id IS NOT NULL
  AND product_id NOT IN(
    SELECT product_id
    FROM products
    WHERE product_id IS NOT NULL
  );
--TULEMUS
--orb_toode = 0 tähendab, et kõik müügitabelis olevad mitte-NULL product_id väärtused leiduvad ka products tabelis
-- Müügid ei viita olematutele toodetele, seega ei ole selle kontrolli põhjal vaja müügikirjeid parandada



--SAMM 3: VAIMKLIENDID. Kontrollin kas on kliente kes pole kunagi ostnud:
SELECT 
  COUNT(*) AS vaimkliendid
FROM customers
WHERE customer_id NOT IN(
  SELECT customer_id
  FROM sales
  WHERE customer_id IS NOT NULL
);
--TULEMUSED: 592
--St:
-- Nende klientide kohta pole sales tabelis ühtegi müügikirjet
-- Nad ei ole andmebaasi praeguste andmete põhjal ostnud
-- Tegemist ei pruugi olla andmeveaga. Nad võivad olla registreerunud kliendid, kes pole lihtsalt ostu teinud
-- Ehk 592 klienti moodustavad potentsiaalse sihtrühma turunduskampaaniatele või kliendi aktiveerimise tegevustele


--SAMM 4: VAIMTOOTED. Kontrollin kas on tooteid mida pole kunagi müüdud.
SELECT 
  COUNT(*) AS vaimtooted
FROM products
WHERE product_id NOT IN (
  SELECT product_id
  FROM sales
  WHERE product_id IS NOT NULL
);
--TULEMUS:
--Neljanda päringu tulemus 12 vaimtoodet tähendab et products tabelis on 12 toodet, mille product_id ei esine kordagi sales tabelis
--Need tooted ei pruugi olla vigased
--Tegemist võib olla toodetega mida pole veel ostetud v mis pole veel müüki jõudnud


--ESIALGNE JÄRELDUS: 
--Müügitabeli ja teiste tabelite vahel ei leitud puuduvaid kliendi- ega tooteviiteid. Küll aga leidus 592 ostuta klienti ja 12 müümata toodet.
--Kokku on nende nelja kontrolli peale 604 leitud kirjet (592 + 12). See on kontrollide tulemuste summa, mitte tingimata 604 erinevat andmekvaliteedi viga.

--SOOVITUS TOOMASELE:
--Kõige rohkem tähelepanu vajavad 592 klienti kes pole ühtegi ostu teinud
--Tasuks uurida, kas nad on endiselt aktiivsed kliendid v pole lihtsalt ostuni jõudnud
--Samuti võiks üle vaadata 12 toodet mida pole müüdud



--EDASIJÕUDNUTE TASE: HINNA-KOOSKÕLA KONTROLL
--Kas müügisumma vastab toote jaehinnale × kogusele?

-- 1. Suurimad hinnaerinevused (LIMIT 20)
SELECT
    s.sale_id,
    s.total_price,
    p.retail_price AS tootehind,
    s.quantity,
    s.total_price - (p.retail_price * s.quantity) AS erinevus
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE ABS(s.total_price - (p.retail_price * s.quantity)) > 1
ORDER BY ABS(s.total_price - (p.retail_price * s.quantity)) DESC
LIMIT 20;
--TULEMUS: leitud näidete hulgas olid suured negatiivsed hinnaerinevused


-- 2. Kõigi hinnakooskõla probleemide arv
SELECT COUNT(*) AS vigase_hinnaga_muugid
FROM sales s
JOIN products p ON s.product_id = p.product_id
WHERE ABS(s.total_price - (p.retail_price * s.quantity)) > 1;
--TULEMUS: 664 müüki


-- 3. Suurima keskmise hinnaerinevusega tooted
SELECT
    p.product_name,
    p.category,
    p.retail_price AS list_hind,
    AVG(s.total_price / NULLIF(s.quantity, 0)) AS kesk_muugihind,
    p.retail_price - AVG(s.total_price / NULLIF(s.quantity, 0)) AS erinevus
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.category, p.retail_price
HAVING ABS(p.retail_price - AVG(s.total_price / NULLIF(s.quantity, 0))) > 5
ORDER BY ABS(p.retail_price - AVG(s.total_price / NULLIF(s.quantity, 0))) DESC
LIMIT 10;
--TULEMUS: 10 toodet, mille keskmine müügihind erines jaehinnast üle 5 EUR


-- 4. Negatiivse müügisummaga kirjete kontroll
SELECT
    COUNT(*) AS negatiivseid_muuke,
    MIN(total_price) AS minimaalne_summa,
    MAX(total_price) AS maksimaalne_summa
FROM sales
WHERE total_price < 0;
--TULEMUS: 305 kirjet.
--Summad jäid vahemikku -1405.32 EUR kuni -16.37 EUR
--Võimalikud põhjused: tagastused, kreeditarved või andmevead
