# Labs — EF Core Through the Eyes of a DBA

**Start here.**

Lab titles and HTTP endpoints are English.

Every lab follows the same rhythm: **Objective → Before you start → Steps → What to record → Exit criterion → If the result is different → Worksheet**. Collect evidence first; draw conclusions second.

## Workshop 1 — From HTTP Request to SQL Server
1. [LAB01](labs/LAB01_HTTP_to_SQL.md) — From HTTP Request to SQL Server
2. [LAB02](labs/LAB02_Deferred_Execution.md) — Deferred Execution
3. [LAB03](labs/LAB03_Overfetching_and_Projection.md) — Over-fetching vs Projection

## Workshop 2 — Execution Plans and Indexes
4. [LAB04](labs/LAB04_Missing_Index.md) — Missing Index: Scan vs Seek
5. [LAB05](labs/LAB05_Covering_Index.md) — Covering Index and Key Lookup
6. [LAB06](labs/LAB06_Query_Shape_and_SARGability.md) — Query Shape and SARGability

## Workshop 3 — Transactions, Locking and Concurrency
7. [LAB07](labs/LAB07_Blocking.md) — Blocking Caused by Application Transaction
8. [LAB08](labs/LAB08_Isolation_Levels.md) — Isolation Levels
9. [LAB09](labs/LAB09_Deadlock.md) — Deadlock

## Workshop 4 — Diagnosing a Real EF Core Workload
10. [LAB10](labs/LAB10_Query_Store_Basics.md) — Query Store Basics
11. [LAB11](labs/LAB11_Incident_Investigation.md) — Incident Investigation: The Endpoint Is Slow
12. [LAB12](labs/LAB12_Final_Challenge.md) — Final Challenge: Developer Meets DBA

Each block is 120 minutes.

Hot customer used across workshops 2–4: **CustomerId 123**.
