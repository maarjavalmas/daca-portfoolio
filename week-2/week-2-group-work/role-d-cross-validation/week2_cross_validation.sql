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


-- ESIALGNE JÄRELDUS: 
--Müügitabeli ja teiste tabelite vahel ei leitud puuduvaid kliendi- ega tooteviiteid. Küll aga leidus 592 ostuta klienti ja 12 müümata toodet.
--Kokku on nende nelja kontrolli peale 604 leitud kirjet (592 + 12). See on kontrollide tulemuste summa, mitte tingimata 604 erinevat andmekvaliteedi viga.

-- SOOVITUS TOOMASELE:
--Kõige rohkem tähelepanu vajavad 592 klienti kes pole ühtegi ostu teinud
--Tasuks uurida, kas nad on endiselt aktiivsed kliendid v pole lihtsalt ostuni jõudnud
--Samuti võiks üle vaadata 12 toodet mida pole müüdud
