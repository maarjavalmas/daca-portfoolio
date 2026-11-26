# Week 2 - Iseseisva töö aruanne

## Eesmärk

Iseseisva töö eesmärk oli kontrollida UrbanStyle'i andmete kvaliteeti SQL päringute abil. Uurisin duplikaate, puuduvaid väärtusi ning andmeformaatide ühtlustamist. Töö käigus tuvastasin võimalikke andmekvaliteedi probleeme ja dokumenteerisin päringute tulemused. Algseid tabeleid ei muudetud ega kustutatud.

## 1. Duplikaatide tuvastamine

### `sales` tabel

Duplikaatide kontrollimisel leidsin 4013 korduvat `sale_id` väärtust. Tabelis oli 15234 rida millest 10 118 olid unikaalse `sale_id`-ga. Üleliigseid ridu oli 5116.

Müügisumma duplikaatidega oli 4374231,27 eurot ja duplikaatideta 2909177,98 eurot. Nende summade vahe oli 1465053,29 eurot.

Tulemused näitavad, et korduvad müügikirjed võivad müügisummat märkimisväärselt suurendada. Enne kirjete eemaldamist tuleb kontrollida kas korduvad read on tegelikud duplikaadid.

### `customers` tabel

Korduvate e-posti aadresside kontrollimisel leidsin 128 erinevat korduvat e-posti aadressi ning kokku 130 üleliigset kliendikirjet. Kaks e-posti aadressi esinesid kolm korda ja ülejäänud korduvad aadressid kaks korda.

Korduvate e-posti aadressidega klientide nimedes esines erinevat kirjapilti, nt suur- ja väiketähtede erinevusi. Enne kirjete eemaldamist tuleb kontrollida kas need kuuluvad samale kliendile.

### `products` tabel

Leidsin 12 korduvat tootenime. Iga tootenimi esines kaks korda, seega oli korduvate nimedega ridu kokku 24 ja üleliigseid ridu 12.

Võrdlesin välju `product_name`, `category`, `subcategory`, `supplier` ja `retail_price`. Kõigi 12 tootepaari puhul olid nende väljade väärtused identsed. Erines ainult `product_id`.

Tulemused viitavad tõenäolistele korduvatele tooterekorditele, enne kustutamist tuleb kontrollida kas mõlema `product_id`-ga on seotud müügitehinguid või laokandeid.

## 2. NULL-väärtused

### `customers` tabel

Tabelis oli kokku 3150 klienti. Kõigil klientidel olid eesnimi ja telefoninumber olemas kuid e-posti aadress puudus 380 kliendil.

`COALESCE()` abil kontrollisin kuidas kuvada puuduva väärtuse asemel asendusteksti, päring leidis 83 klienti kellel puudus vähemalt üks kontrollitud väärtustest: eesnimi, perekonnanimi, e-post või telefon.

`COALESCE()` muutis ainult päringu tulemust, mitte `customers` tabeli algandmeid.

### `sales` tabel

NULL-väärtuste kontrolli päring näitas 10118 rida. Kõigil ridadel oli `total_price` olemas, puuduvaid summasid oli 0. Kogusumma oli 2909177,98 eurot ja keskmine 287,53 eurot.

Selle päringu tulemuse põhjal ei jätnud `SUM()` ega `AVG()` `total_price` veeru puhul ühtegi rida NULL-väärtuse tõttu arvutusest välja.

## 3. Andmeformaadid ja tüübikonversioonid

### Kuupäevade vormindamine

Kasutasin `TO_CHAR()` funktsiooni kuupäevade esitamiseks eri formaatides ning kontrollisin kuupäevast nädalapäeva ja kvartali leidmist, viimase päringuga leitud müügikuupäev oli 28.06.2026 ning see kuulus 2026. aasta teise kvartalisse.

### Linnanimede ühtlustamine

Kontrollisin linnanimede kirjapilte ning katsetasin nende ühtlustamist funktsioonidega `TRIM()` ja `INITCAP()`.

Tulemuse põhjal oli 12 erinevat linnanime ning samal linnal ei esinenud mitut erinevat kirjaviisi, puhastatud linnanimede arv jäi samaks.

### Toodete hindade kontroll

Kontrollisin `products` tabeli `retail_price` väärtusi, otsides puuduvaid, null- ja negatiivseid hindu. Päring ei leidnud ühtegi sellise hinnaga toodet.

See päring kontrollis hinnaväärtusi kuid ei kasutanud `CAST`-i ega kontrollinud tekstiväärtuste teisendamist.

## Kokkuvõte

Töö käigus tuvastasin korduvaid kirjeid müügi-, kliendi- ja tootetabelites ning kontrollisin NULL-väärtuste ja andmeformaatide mõju andmete analüüsimisele. Tulemused näitasid, et korduvad kirjed võivad mõjutada müügisummat ning enne andmete kustutamist tuleb kontrollida kas tegemist on duplikaatidega.

Harjutused keskendusid andmete kontrollimisele ja tulemuste dokumenteerimisele. Algseid tabeleid ei muudetud ega kustutatud.

## Märkus tulemuste kontrollimise kohta

Duplikaatide analüüsi päringus oli `sales` tabelis 15234 rida kuid NULL-väärtuste kontrolli päringus 10 118 rida. Need tulemused tuleb üle kontrollida, sest samast muutmata tabelist tehtud päringute ridade arv peaks kattuma.
