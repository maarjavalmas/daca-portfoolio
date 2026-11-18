# Week 2 - Ristvalideerimise raport

## Eesmärk

Kontrollida UrbanStyle'i andmebaasi tabelite `sales`, `customers` ja `products` omavahelist andmete terviklikkust.

Kontrollisin, kas müügitabelis viidatud kliendid ja tooted on vastavates tabelites olemas ning kas leidub kliente, kes pole kunagi ostnud, ja tooteid, mida pole kunagi müüdud.

## Tulemused

| Kontroll | Leitud kirjete arv | Tulemus |
|---|---:|---|
| Orbid kliendid | 0 | Kõik müügis viidatud kliendid on `customers` tabelis olemas |
| Orbid tooted | 0 | Kõik müügis viidatud tooted on `products` tabelis olemas |
| Vaimkliendid | 592 | 592 klienti pole kunagi ostnud |
| Vaimtooted | 12 | 12 toodet pole kunagi müüdud |

## Järeldused

- Müügitabelis ei leitud viiteid klientidele, keda `customers` tabelis pole.
- Müügitabelis ei leitud viiteid toodetele, mida `products` tabelis pole.
- 592 klienti ei esine müügitehingutes.
- 12 toodet ei esine müügitehingutes.

Nelja kontrolli tulemuste summa on 604 kirjet. See on kategooriate arvude summa, mitte tingimata unikaalsete probleemsete kirjete arv.

## Soovitused

Kõigepealt tuleks kontrollida, miks 592 klienti pole ostnud. Need kliendid ei pruugi olla vigased, nad võivad olla registreerunud kliendid kes pole veel ostu sooritanud.

Samuti tuleks uurida 12 müümata toodet, et selgitada kas need on uued, aktiivsest müügist väljas või lihtsalt veel müümata tooted.

Orvuks jäänud kliendi- ja tooteviiteid ei leitud, seega nende kontrollide põhjal pole vaja müügitabeli seoseid parandada.

## Kokkuvõte

Ristvalideerimise käigus ei leitud puuduvaid kliendi- ega tooteviiteid. Leiti 592 klienti, kes pole ostnud ning 12 toodet mida pole müüdud. Tulemused vajavad ärilist tõlgendamist enne võimalike muudatuste tegemist andmetes.
