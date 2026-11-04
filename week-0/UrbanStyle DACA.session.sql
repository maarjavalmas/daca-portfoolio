-- =========
-- DACA NÄDAL 0 – GRUPITÖÖ
-- MEESKOND: Sales Analytics
-- ROLL: B – Supabase Seadistaja
-- VASTUTAJA: Maarja Valmas
-- KUUPÄEV: 03.11.2026
-- =========

-- 1. TABELI LOOMINE
-- Loon meeskonnale ühise tabeli team_members.
-- Selles tabelis on kõigi liikmete andmeid.
CREATE TABLE team_members (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    role_week1 TEXT NOT NULL,
    os TEXT NOT NULL,
    joined_date DATE DEFAULT CURRENT_DATE
);

-- 2. MEESKONNALIIKMETE LISAMINE
-- Lisan tabelisse kõik neli meeskonnaliiget.
-- Salvestan nende nimed, rollid ja ühise liitumiskuupäeva.
INSERT INTO team_members (name, role_week1, os, joined_date)
VALUES
('Sigrid Nieländer', 'A: GitHub Repo Seadistaja', 'Windows', '2026-11-03'),
('Marleen Aavere', 'C: NotebookLM Seadistaja', 'Windows', '2026-11-03'),
('Marje Piirisild', 'D: Team Charter Koostaja', 'Windows', '2026-11-03'),
('Maarja Valmas', 'B: Supabase Seadistaja', 'Windows', '2026-11-03');

-- 3. KÕIKIDE ANDMETE KUVAMINE
-- Kontrollin, kas kõik neli meeskonnaliiget on tabelisse lisatud.
-- Tärn (*) kuvab kõik tabeli veerud.
SELECT * FROM team_members;

-- 4. ANDMETE SORTEERIMINE
-- Kuvan liikmete nimed ja rollid.
-- ORDER BY järjestab liikmed tähestikuliselt.
SELECT name, role_week1
FROM team_members
ORDER BY name;