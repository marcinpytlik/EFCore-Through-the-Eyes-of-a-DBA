# Rubryka oceny warsztatu

| Obszar | 0 pkt | 1 pkt | 2 pkt | 3 pkt |
|---|---|---|---|---|
| SQL generowany przez EF Core | Nie potrafi wskazać | Wskazuje tylko SQL | Łączy LINQ z SQL | Wyjaśnia query shape i konsekwencje |
| Execution plans | Nie potrafi czytać operatorów | Rozpoznaje Scan/Seek | Wyjaśnia Lookup/estimates | Używa dowodów z planu do poprawki |
| Indeksowanie | Brak użytecznej propozycji | Indeks bez dowodów | Trafny wybór klucza | Równoważy korzyść covering i koszt |
| Transakcje / blocking | Nie potrafi wskazać blockera | Znajduje blockera | Wyjaśnia lifetime | Proponuje bezpieczną korektę |
| Isolation / deadlocki | Miesza pojęcia | Rozpoznaje pojęcie | Wyjaśnia dirty read/cykl | Prevention + strategia retry |
| Query Store | Nie potrafi zlokalizować zapytania | Znajduje zapytanie | Czyta metryki | Używa go do walidacji poprawki |
| Analiza root cause | Zgaduje | Słabe wyjaśnienie | Używa dowodów | Poprawnie rozdziela Application/Database/Both |
| Validation | Brak | Subiektywna | Jedna metryka | Wiele niezależnych punktów dowodowych |

Maksimum: **24 punkty**

- 21–24: Doskonale
- 17–20: Bardzo dobrze
- 13–16: Dobrze
- 9–12: Zaliczenie podstawowe
- 0–8: Wymaga dalszej praktyki
