### Week 2: SQL - Andmete puhastamine ja ristvalideerimine

## Projekt

**UrbanStyle - andmekvaliteedi kontrollimine SQL-i abil**

## Mida ma tegin?

Nädala jooksul kasutasin SQL'i UrbanStyle'i andmete kvaliteedi kontrollimiseks. Iseseisvas töös uurisin korduvaid kirjeid, puuduvaid väärtusi ning kuupäevade ja linnanimede vormindamist. Grupitöös kontrollisin müügi-, kliendi- ja tooteandmete omavahelisi seoseid ning võrdlesin teise meeskonna päringu tulemusi enda tulemustega.

## Mida ma õppisin?

Harjutasin `GROUP BY`, `HAVING`, `ROW_NUMBER()`, `COALESCE()`, `TO_CHAR()`, `TRIM()`, `INITCAP()`, `CASE WHEN` ja `JOIN` kasutamist. Õppisin, et korduvaid kirjeid ei tohiks automaatselt kustutada vaid enne tuleb kontrollida kas need on tegelikud duplikaadid või tavapärased äritehingud.

## Mida soovin järgmisena õppida?

Soovin õppida keerukamaid SQL päringuid omavahel ühendama ning andmete kvaliteeti süsteemsemalt kontrollima.

## Failid ja tööd

### Iseseisev töö

Iseseisva töö kirjeldus ja failid asuvad [Week 2 iseseisva töö kaustas](https://github.com/maarjavalmas/daca-portfoolio/tree/main/week-2/week-2-independent-work).

### Grupitöö - Roll D: Cross-validation

Kontrollisin müükides viiteid puuduvatele klientidele ja toodetele, uurisin ostmata kliente ning müümata tooteid ja võrdlesin müügisummasid toodete jaehindadega. Samuti kontrollisin teise meeskonna päringu tulemuste korratavust.

Grupitöö SQL-päringud, raport ja ekraanipildid asuvad [Roll D – Cross-validation kaustas](https://github.com/maarjavalmas/daca-portfoolio/tree/main/week-2/week-2-group-work/role-d-cross-validation).

## Andmekvaliteedi raport

Koondasin SQL-päringuga andmetes esinevate probleemide arvud ning koostasin nende põhjal andmekvaliteedi raporti. Kasutasin tehisaru abi päringu ja raporti sõnastamisel ning kontrollisin tulemused ise Supabase’is üle.

- [Andmekvaliteedi SQL-päring](https://github.com/maarjavalmas/daca-portfoolio/blob/main/week-2/week-2-independent-work/week2_kvaliteet.sql)
- [Toomase puhastamisraport](https://github.com/maarjavalmas/daca-portfoolio/blob/main/week-2/week-2-independent-work/Toomase_puhastamisraport.md).

## Lõpuesitluse leid

----------------------
