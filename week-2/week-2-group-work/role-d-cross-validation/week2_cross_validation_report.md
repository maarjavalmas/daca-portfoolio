# Week 2 – Ristvalideerimise raport

## Eesmärk

Minu ülesanne oli kontrollida kas UrbanStyle'i müügi-, kliendi- ja tooteandmed on omavahel kooskõlas. Uurisin ka kas leidub kliente kes pole kunagi ostnud, ja tooteid mida pole kordagi müüdud.

## Tulemused

| Kontroll | Tulemus |
|---|---:|
| Müükides viited puuduvatele klientidele | 0 |
| Müükides viited puuduvatele toodetele | 0 |
| Kliendid, kes pole ostnud | 592 |
| Tooted, mida pole müüdud | 12 |
| Hinnaerinevusega müügid (edasijõudnute tase) | 664 |

Baastaseme nelja kontrolli tulemuste summa on 604.

## Edasijõudnute analüüs

Kasutasin JOIN-i, et võrrelda müügisummat toote jaehinna ja koguse korrutisega.

- Leidsin 664 müüki, mille hinnavahe oli suurem kui 1 €
- 10 toote keskmine müügihind erines jaehinnast rohkem kui 5 €
- Leidsin 305 negatiivse müügisummaga kirjet
- Negatiivsed summad jäid vahemikku -1405,32 € kuni -16,37 €

Hinnaerinevuste põhjuseks võivad olla allahindlused, tagastused, kreeditarved või andmevead, nende põhjuste väljaselgitamiseks oleks vaja andmeid täiendavalt uurida.

## Teise meeskonna päringu ristvalideerimine

Kontrollisin Klienditeeninduse meeskonna e-posti aadresside päringut oma `customers_test` tabelis.

| Näitaja | Nende tulemus | Minu tulemus |
|---|---:|---:|
| Enne | 2770 | 2770 |
| Pärast | 2640 | 2640 |

Sain täpselt samad tulemused, seega oli Klienditeeninduse meeskonna päring minu testtabelis korratav.

## Järeldused ja soovitused

Müügitabelis ei leitud viiteid puuduvatele klientidele ega toodetele. St et nende tabelite vahelised seosed on korras.

Samas leidus 592 klienti kes pole ostnud, ja 12 toodet mida pole müüdud. Samuti vajavad lähemat uurimist müügi- ja tootehindade erinevused ning negatiivsed müügisummad.

Enne andmete muutmist või kustutamist tuleks välja selgitada kas tegemist on andmevigade või tavapäraste äritehingutega.

## Kokkuvõte

Kokkuvõttes näitasid kontrollid, et müügitabeli kliendi- ja tooteviited olid korras. Samas tõid analüüsid välja mitu kohta mis vajavad täiendavat uurimist. Teise meeskonna päringu kontrollimine kinnitas, et sain oma testtabelis samad tulemused.
