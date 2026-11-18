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
| Hinna ebakõlad (edasijõudnud) | Kontrollimata | Müügihind ei klapi tootehinnaga |
| Kokku probleeme | 604 | Nelja baastaseme kontrolli tulemuste summa |

## Järeldused

- Müügitabelis ei leitud viiteid klientidele, keda `customers` tabelis pole.
- Müügitabelis ei leitud viiteid toodetele, mida `products` tabelis pole.
- 592 klienti ei esine müügitehingutes.
- 12 toodet ei esine müügitehingutes.

Nelja kontrolli tulemuste summa on 604 kirjet. See on kategooriate arvude summa, mitte tingimata unikaalsete probleemsete kirjete arv.

## Soovitused

Kõige rohkem tähelepanu vajavad 592 klienti kes pole ühtegi ostu teinud. 
Tasuks uurida kas nad on endiselt aktiivsed kliendid või pole lihtsalt ostuni jõudnud. Samuti võiks üle vaadata 12 toodet mida pole veel müüdud. Neid ei tohiks automaatselt kustutada.

## Kokkuvõte

Ristvalideerimise käigus ei leitud puuduvaid kliendi- ega tooteviiteid. Leiti 592 klienti, kes pole ostnud ning 12 toodet mida pole müüdud. Tulemused vajavad ärilist tõlgendamist enne võimalike muudatuste tegemist andmetes.
