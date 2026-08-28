# LAB08 — Isolation Levels

## Objective
Observe how isolation level changes reader/writer interaction.

## Student Instructions
1. Open a transaction in Session A and update OrderId 10 without committing.
2. Read the same row in Session B under READ COMMITTED.
3. Then switch Session B to READ UNCOMMITTED and repeat.
4. Rollback Session A.
5. Discuss dirty reads and why NOLOCK is not a universal blocking fix.

## Deliverable
Record observations, evidence and a short conclusion for the lab.