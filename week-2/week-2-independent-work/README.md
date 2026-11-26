# Week 2 - Iseseisev töövihik

## Eesmärk

Iseseisva töö eesmärk oli harjutada SQL'i abil andmete kvaliteedi kontrollimist ja puhastamist. Uurisin duplikaate, puuduvaid väärtusi ning andmeformaatide ühtlustamist.

## Teemad ja tegevused

- Müügi-, kliendi- ja tooteandmete duplikaatide tuvastamine
- GROUP BY, HAVING ja ROW_NUMBER() kasutamine korduvate kirjete leidmiseks
- Puuduvate väärtuste kontrollimine ja COALESCE() kasutamine asendusväärtuse kuvamiseks
- Kuupäevade vormindamine ja kuupäevafunktsioonide kasutamine
- Linnanimede kirjapildi kontrollimine ja puhastamise katsetamine funktsioonidega TRIM() ja INITCAP()
- Toodete hindade kontrollimine CASE WHEN abil
- Päringute tulemuste kontrollimine 

## Failid

- `week2_independent_work.sql` - iseseisva töö SQL päringud koos kommentaaride ja tulemustega.
- `week2_independent_work_report.md` - töövihiku vastused, tulemuste kokkuvõte ja järeldused.
- `screenshots/` - Supabase’i päringute tulemuste ekraanipildid.

## Olulisemad tulemused

- Müügitabelis leidsin 4013 korduvat sale_id väärtust ja 5116 üleliigset rida. Kordustega arvutatud müügisumma oli 1465053,29 EUR suurem kui kordusteta arvutatud summa
- Klienditabelis leidsin 128 korduvat e-posti aadressi mille peale kokku tuli 130 üleliigset rida
- Tootetabelis leidsin 12 korduvat tootenime, iga nimi esines kaks korda ning kontrollitud tooteandmed kattusid, erines product_id
- COALESCE() abil sai puuduva väärtuse asemel kuvada asendusväärtuse ilma et tabeli algandmed muutuksid
- Kuupäevade vormindamisel kontrollisin kuupäeva esitust, nädalapäeva ja kvartalit
- Linnanimede kontrollis leidsin 12 puhastatud linna ning igal linnal oli üks algne kirjaviis
- Toodete hindade kontrollis ei leidnud ühtegi NULL, null- või negatiivse hinnaga toodet
  
## Järeldus

Harjutused näitasid, et enne andmete muutmist tuleb probleemsed väärtused tuvastada, tulemused üle kontrollida ja otsused dokumenteerida. Päringute käivitamine ei tähenda automaatselt, et algandmeid on muudetud.
