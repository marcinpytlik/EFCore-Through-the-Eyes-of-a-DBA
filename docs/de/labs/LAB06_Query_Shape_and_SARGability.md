# LAB06 — Query Shape and SARGability

## Ziel
Zeigen, wie die Form eines Prädikats die Indexnutzung in SQL und EF Core beeinflusst.

## Zeit
30–35 min.

## Vor dem Start
- Workshop 2 sollte im Zustand nach LAB05 sein.
- `IX_Customers_Name` sollte bereits durch das Setup existieren.
- VS Code mit Actual Execution Plan und `Workshop.Api.http` vorbereiten.

## Vorbereitung
Baseline-Index prüfen, statt ein Duplikat anzulegen:
```sql
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID(N'dbo.Customers')
  AND name = N'IX_Customers_Name';
```

## Schritte
1. Ein direktes Prädikat `Name = @name` mit `UPPER(Name) = UPPER(@name)` vergleichen.
2. `SET STATISTICS IO/TIME` und Actual Execution Plan verwenden.
3. Aufrufen:
   - `GET /workshop2/customers/search-bad/Customer%20123`
   - `GET /workshop2/customers/search-good/Customer%20123`
4. Generiertes SQL, Access Operator und Logical Reads vergleichen.

## Was notieren?
- SQL für Direct Equality und `UPPER()`,
- Access Operator beider Varianten,
- Logical Reads,
- SQL beider EF-Core-Endpoints,
- vorgeschlagene Prädikatänderung.

## Erwartetes Ergebnis
Funktional korrektes LINQ wie `ToUpper()` kann weniger effizientes SQL erzeugen. SARGability ist eine Eigenschaft der Prädikatform, keine „EF-Magie“.

## Abschlusskriterium
Sie können den LINQ-Ausdruck mit dem generierten SQL verbinden und Scan vs Seek durch die Prädikatform erklären.

## Wenn das Ergebnis anders ist
- `IX_Customers_Name` fehlt: Setup erneut ausführen, statt einen zweiten Index anzulegen.
- Plan weicht ab: Collation, Actual Plan und Reads prüfen; kein bestimmtes Ergebnis erzwingen.
- Beide Endpoints liefern dieselbe Zeile: korrekt — verglichen wird der Weg zum Ergebnis.

## Fragen
- Was sieht SQL Server statt `c.Name.ToUpper()`?
- Warum kann eine Funktion auf der indizierten Spalte einen Seek erschweren?
- Kann Collation die Vergleichssemantik verändern?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB06_WORKSHEET.md](../worksheets/LAB06_WORKSHEET.md).
