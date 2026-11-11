# Nädal 1 – SQL-i põhiteadmised

## Projekt
UrbanStyle – müügiandmete uurimine

## Miks ma seda projekti tegin?

Projekti eesmärk oli tutvuda UrbanStyle'i andmebaasiga ja uurida ettevõtte müügiandmeid. Tahtsin teada, millised andmed tabelites on ja kas nende hulgas leidub vigu või puuduvaid väärtusi.

## Mida ma tegin?
Kasutasin SQL-i, et uurida müügi-, kliendi- ja tooteandmeid. Otsisin duplikaate, puuduvaid kliendi ID-sid, erinevaid müügikanaleid ning kõige suuremaid ja väiksemaid müüke.

## Mida ma õppisin?
Õppisin kasutama järgmisi SQL-käske:

- `SELECT` ja `FROM` - andmete valimiseks tabelitest.
- `AS` - veergude ümbernimetamiseks päringu tulemuses.
- `ORDER BY` ja `LIMIT` - andmete sorteerimiseks ja tulemuste piiramiseks.
- `WHERE` - andmete filtreerimiseks.
- `BETWEEN`, `IN` ja `LIKE` - kindlate väärtuste ja tekstide otsimiseks.
- `AND` ja `OR` - mitme tingimuse ühendamiseks.
- `DISTINCT` - ainult erinevate väärtuste leidmiseks.
- `COUNT` - ridade ja väärtuste loendamiseks.
- `IS NULL` - puuduvate väärtuste leidmiseks.

## Praktilised ülesanded
Uurisin müügi-, kliendi- ja tooteandmeid.

Samuti leidsin ja uurisin:
- Müügitabeli duplikaatide arvu.
- Puuduvaid kliendi ID-sid.
- Kõige suuremaid müüke.
- Nulli või negatiivse summaga müüke.
- Erinevaid müügikanaleid ja tootekategooriaid.

## Mida ma teada sain?

Sain parema ülevaate andmebaasi sisust ja õppisin märkama andmetes esinevaid probleeme. Samuti sain esimest korda SQL-i abil ise andmeid uurida ja päringuid kirjutada.

## Milliste raskustega kokku puutusin?
Alguses oli keeruline SQL-i süntaks, eriti komade ja semikoolonite õige kasutamine ning käskude õige järjekord.

Samuti vajasid harjutamist `NULL`-väärtuste leidmine, `COUNT`-käskude erinevused ja duplikaatide tuvastamine.

## Mida soovin järgmisena õppida?
Soovin õppida SQL-käske omavahel paremini ühendama, kirjutada keerukamaid päringuid ning analüüsida andmeid iseseisvamalt.

## Failid
## Failid

- `week1_urbanstyle_exploration.sql` - kõik SQL-päringud koos kommentaaridega.
- `README.md` - nädala kokkuvõte ja õpitu.
- `01_select.png` - SELECT-päringu tulemus.
- `02_where.png` - WHERE-päringu tulemus.
- `03_distinct.png` - unikaalsed müügikanalid.
- `04_count.png` - andmete loendamise tulemus.
- `05_duplicates.png` - duplikaatide arv.
- `06a_largest_sales.png` - 10 suurimat müüki.
- `06b_smallest_sales.png` - 10 väikseimat müüki.


