# Week 1 – Group Work
## Roll C – Products (Tooteandmete analüüs)

### Eesmärk

Minu ülesanne oli uurida UrbanStyle'i `products` tabelit, kontrollida toodete andmeid, kategooriaid ja hindu ning leida võimalikud andmekvaliteedi probleemid.

### 1. Toodete üldine ülevaade

- Toodete koguarv: **362**
- Erinevaid tootenimesid: **350**
- Tabelis on 9 veergu: `product_id`, `product_name`, `category`, `subcategory`, `supplier`, `cost_price`, `retail_price`, `eco_certified`, `created_at`.
- Erinevaid tootekategooriaid: **5**.

Kategooriad ja toodete arv:

| Kategooria | Toodete arv |
|---|---:|
| Meesteriided | 82 |
| Jalanõud | 73 |
| Lasteriided | 70 |
| Naisteriided | 70 |
| Aksessuaarid | 67 |
| **Kokku** | **362** |

### 2. Hindade analüüs

- Kõige kallim toode: Õhuline sünteetiline sporditossud – **434,08 €**.
- Kõige odavam toode: Vintage villane kangasvöö – **13,53 €**.
- Üldine hinnavahemik: **13,53–434,08 €**.

Kategooriate hinnavahemikud:

| Kategooria | Min hind | Max hind |
|---|---:|---:|
| Jalanõud | 58,49 € | 434,08 € |
| Meesteriided | 48,85 € | 374,54 € |
| Naisteriided | 32,93 € | 351,33 € |
| Aksessuaarid | 13,53 € | 231,13 € |
| Lasteriided | 22,70 € | 168,82 € |

Jalanõude kategoorias on kõige kallim toode, aksessuaaride kategoorias kõige odavam.

### 3. Andmekvaliteedi kontroll

Kontrollisin, kas toodetel on olemas vajalikud andmed.

| Kontrollitud veerg | Puuduvate väärtuste arv |
|---|---:|
| `retail_price` | 0 |
| `category` | 0 |
| `eco_certified` | 18 |

Kõigil toodetel on hind ja kategooria olemas. 18 tootel puudub ökosertifikaadi info (`NULL`).

Lisaks leidsin 12 korduvat tootenime, millest igaüks esineb tabelis kaks korda. Seetõttu on tabelis 362 rida, kuid erinevaid tootenimesid 350.

Üks kontrollitud duplikaadikahtlus oli näiteks ID 1212 ja 1353 – mõlema toote kõik nähtavad andmed olid identsed.

### 4. Täiendavad ülesanded

Lisaks põhiülesannetele uurisin veel:

- Toodete arvu kategooriate kaupa, kasutades `GROUP BY` ja `COUNT()`.
- Kategooriate hinnavahemikke, kasutades `MIN()` ja `MAX()`.
- Toodete filtreerimist mitme tingimuse alusel, kasutades `WHERE` ja `AND`.

Näiteks filtreerisin naisteriiete kategooriast tooted, mille jaehind on üle 50 euro. Tingimustele vastas **67 toodet 70-st**.

Samuti võrdlesin omahinda ja jaehinda ning leidsin tooteid, mille jaehind oli omahinnast madalam. Näiteks tootel ID 1027 oli omahind 346,70 €, kuid jaehind 213,35 €. Need hinnad vajavad täiendavat kontrollimist.

### 5. Kokkuvõte

Analüüsi käigus sain ülevaate UrbanStyle'i toodetest, kategooriatest ja hindadest. Leidsin 12 korduvat tootenime ning 18 toodet, millel puudub ökosertifikaadi info. Hinnad ja kategooriad olid kõigil toodetel olemas. Lisaks uurisin kategooriate hinnavahemikke ja filtreerisin tooteid erinevate tingimuste alusel.

Töö käigus kasutasin SQL-käske `SELECT`, `COUNT()`, `DISTINCT`, `WHERE`, `AND`, `ORDER BY`, `GROUP BY`, `HAVING`, `MIN()` ja `MAX()`.

---

### Failid

- `week1_products_exploration.sql` – analüüsi käigus kasutatud SQL-päringud.
- `products_analysis_notes.md` – päringute tulemused ja täpsemad märkmed.
- `screenshots/` – päringute tulemuste ekraanitõmmised.
