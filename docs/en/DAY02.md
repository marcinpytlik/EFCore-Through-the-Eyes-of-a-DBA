# Day 2 — Plans, Indexes and Concurrency

## Goal

Understand how SQL Server executes the generated workload and how application transaction behaviour affects concurrency.

## Start of day

1. Start the database and API.
2. Verify the state left by LAB04 or reset if the instructor asks you to.
3. Enable Actual Execution Plan in the SQL editor.
4. Keep two request windows available for concurrency labs.
5. Open `Workshop2Endpoints.cs` and `Workshop3Endpoints.cs`.

## Labs

### LAB05 — Covering Index and Key Lookup
See why an Index Seek can still be paired with additional lookup work.

[Open LAB05](labs/LAB05_Covering_Index.md)

### LAB06 — Query Shape and SARGability
Compare functionally equivalent predicates with different access paths.

[Open LAB06](labs/LAB06_Query_Shape_and_SARGability.md)

### LAB07 — Blocking
Observe a request waiting behind a transaction that remains open.

[Open LAB07](labs/LAB07_Blocking.md)

### LAB08 — Isolation Levels
Compare concurrent reads under different isolation behaviour.

[Open LAB08](labs/LAB08_Isolation_Levels.md)

### LAB09 — Deadlock
Create a dependency cycle, identify the victim and inspect the deadlock evidence.

[Open LAB09](labs/LAB09_Deadlock.md)

## End-of-day checkpoint

Before moving to Day 3, make sure you can answer:

1. Why is Seek not automatically equal to “good plan”?
2. What is a Key Lookup?
3. What makes a predicate non-SARGable?
4. How do you identify blocker and blocked session?
5. What is the difference between blocking and deadlock?
6. What evidence is stronger than a single error message when diagnosing a deadlock?
