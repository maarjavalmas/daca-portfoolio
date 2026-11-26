### Week 2: SQL – Andmete puhastamine ja ristvalideerimine

## Projekt

**UrbanStyle – andmekvaliteedi kontrollimine SQL-i abil**

## Miks ma seda projekti tegin?

Projekti eesmärk oli õppida SQL-i abil kontrollima andmete kvaliteeti ning tuvastama võimalikke probleeme müügi-, kliendi- ja tooteandmetes. Soovisin mõista, kuidas duplikaadid, puuduvad väärtused ja andmete erinevad vormingud võivad analüüsi tulemusi mõjutada.

## Mida ma tegin?

Kasutasin SQL-i UrbanStyle'i andmete kontrollimiseks ja analüüsimiseks. Uurisin korduvaid kirjeid, kontrollisin puuduvaid väärtusi ning harjutasin kuupäevade ja linnanimede vormindamist.

Grupitöös kontrollisin müügi-, kliendi- ja tooteandmete omavahelisi seoseid ning võrdlesin teise meeskonna päringu tulemusi enda testtabeli tulemustega.

## Mida ma õppisin?

Harjutasin järgmiste SQL-käskude ja funktsioonide kasutamist:

- `GROUP BY` ja `HAVING` – korduvate kirjete leidmiseks.
- `ROW_NUMBER()` – kirjete järjestamiseks ja korduste uurimiseks.
- `COALESCE()` – puuduva väärtuse asemel asendusväärtuse kuvamiseks.
- `TO_CHAR()` – kuupäevade vormindamiseks.
- `TRIM()` ja `INITCAP()` – tekstiväärtuste puhastamise ja ühtlustamise katsetamiseks.
- `CASE WHEN` – tingimuste alusel väärtuste kontrollimiseks.
- `JOIN` – eri tabelite andmete võrdlemiseks ja seoste kontrollimiseks.

## Praktilised ülesanded

Iseseisvas töös uurisin:

- Müügi-, kliendi- ja tooteandmete duplikaate.
- Puuduvaid väärtusi klientide ja müükide andmetes.
- Duplikaatide võimalikku mõju müügisummale.
- Kuupäevade vormindamist ja kuupäevafunktsioonide kasutamist.
- Linnanimede kirjapilti ja ühtlustamist.
- Toodete hindade sobivust.

Grupitöös uurisin:

- Müükides viiteid puuduvatele klientidele ja toodetele.
- Kliente, kes polnud ostnud, ning tooteid, mida polnud müüdud.
- Müügisummade ja toodete jaehindade erinevusi.
- Negatiivse müügisummaga kirjeid.
- Teise meeskonna päringu tulemuste korratavust.

## Mida ma teada sain?

Sain parema arusaama sellest, kuidas andmekvaliteedi probleemid võivad analüüsi tulemusi mõjutada. Õppisin, et korduvaid kirjeid ei tohiks automaatselt kustutada, vaid enne tuleb kontrollida, kas tegemist on tegelike duplikaatide või tavapäraste äritehingutega.

Grupitöö käigus sain harjutada ka teiste analüütikute päringute kontrollimist ja tulemuste võrdlemist.

## Milliste raskustega kokku puutusin?

Keerulisem oli eristada korduvaid kirjeid tegelikest andmetest ning hinnata, millal võib erinevus viidata andmeveale ja millal tavapärasele äritehingule. Samuti tuli tulemuste tõlgendamisel arvestada, et päringute tulemused sõltuvad kasutatud tabelitest ja tingimustest.

## Mida soovin järgmisena õppida?

Soovin õppida keerukamaid SQL-päringuid omavahel ühendama, andmete kvaliteeti süsteemsemalt kontrollima ning kasutada SQL-i tulemusi edasises andmeanalüüsis.

## Failid

**Iseseisev töö**
- `week2_independent_work.sql` – iseseisva töö SQL-päringud koos kommentaaridega.
- `week2_independent_work_report.md` – iseseisva töö tulemused ja järeldused.
- `screenshots/` – päringute tulemuste ekraanipildid.

**Grupitöö**
- `week-2-group-work/role-d-cross-validation/` – ristvalideerimise grupitöö failid ja ekraanipildid.

Grupitöö SQL-päringud, raport ja ekraanipildid asuvad [Roll D – Cross-validation kaustas](https://github.com/maarjavalmas/daca-portfoolio/tree/main/week-2/week-2-group-work/role-d-cross-validation).
