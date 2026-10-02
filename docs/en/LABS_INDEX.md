# Labs — EF Core Through the Eyes of a DBA

Every lab follows the same rhythm:

**Objective → Before you start → Steps → What to record → Exit criterion → If the result is different → Questions / Worksheet**

Collect evidence first; draw conclusions second.

For the recommended 3-day sequence, see [COURSE_MAP.md](COURSE_MAP.md).

## Day 1 — From HTTP Request to SQL Server

1. [LAB01](labs/LAB01_HTTP_to_SQL.md) — From HTTP Request to SQL Server
2. [LAB02](labs/LAB02_Deferred_Execution.md) — Deferred Execution
3. [LAB03](labs/LAB03_Overfetching_and_Projection.md) — Over-fetching vs Projection
4. [LAB04](labs/LAB04_Missing_Index.md) — Missing Index: Scan vs Seek

## Day 2 — Plans, Indexes and Concurrency

5. [LAB05](labs/LAB05_Covering_Index.md) — Covering Index and Key Lookup
6. [LAB06](labs/LAB06_Query_Shape_and_SARGability.md) — Query Shape and SARGability
7. [LAB07](labs/LAB07_Blocking.md) — Blocking Caused by Application Transaction
8. [LAB08](labs/LAB08_Isolation_Levels.md) — Isolation Levels
9. [LAB09](labs/LAB09_Deadlock.md) — Deadlock

## Day 3 — Query Store and Real Workload Diagnosis

10. [LAB10](labs/LAB10_Query_Store_Basics.md) — Query Store Basics
11. [LAB11](labs/LAB11_Incident_Investigation.md) — Incident Investigation: The Endpoint Is Slow
12. [LAB12](labs/LAB12_Final_Challenge.md) — Final Challenge: Developer Meets DBA

Hot customer used in several labs: **CustomerId 123**.

## Final principle

Do not optimize from memory or from a label such as Scan, Seek, blocking or N+1.

Capture evidence, explain the workload, then choose a fix and define how you will validate it.
