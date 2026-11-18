# Week 2 – Ristvalideerimise raport

## Eesmärk

Kontrollida, kas UrbanStyle'i müügi-, kliendi- ja tooteandmed on omavahel kooskõlas. Uurisin ka kas on kliente kes pole ostnud ja tooteid mida pole müüdud.

## Tulemused

| Kontroll | Tulemus |
|---|---:|
| Orbid kliendid | 0 |
| Orbid tooted | 0 |
| Kliendid, kes pole ostnud | 592 |
| Tooted, mida pole müüdud | 12 |
| Hinnaerinevusega müügid (edasijõudnute tase) | 664 |

Baastaseme nelja kontrolli tulemuste summa on 604.

## Edasijõudnute analüüs

Kontrollisin JOIN-i abil, kas müügisumma vastab toote jaehinna ja koguse korrutisele.

- Leidsin 664 müüki, mille hinnavahe oli üle 1 €.
- 10 tootel erines keskmine müügihind jaehinnast rohkem kui 5 €.
- Lisaks leidsin 305 negatiivse müügisummaga kirjet.
- Negatiivsed summad jäid vahemikku -16,37 € kuni −1405,32 €.

Võimalik, et osa erinevustest on seotud allahindluste, tagastuste või andmevigadega. Seda tuleks täpsemalt uurida.

## Järeldused ja soovitused

Müügitabelis puuduvad viited olematutele klientidele ja toodetele, mis on positiivne tulemus.

Samas on 592 klienti kes pole ostnud, ja 12 toodet mida pole müüdud. Samuti vajavad kontrollimist hinnavahed ja negatiivsed müügisummad.

Enne andmete kustutamist või muutmist tuleks välja selgitada kas tegemist on tegelike vigade või tavapäraste äritehingutega.

## Kokkuvõte

Baastaseme kontrollid näitasid, et kliendi- ja tooteviited on korras. Edasijõudnute analüüs tõi välja mitmeid hinnaerinevusi mida tasub lähemalt uurida. Kõik leitud probleemid ei tähenda automaatselt, et andmed on valed.
