# LAB11 — Incident Investigation: The Endpoint Is Slow

## Objective
Perform a SQL-first investigation before reading application code.

## Student Instructions
1. Start only from the incident statement: `/workshop4/customer/123/orders-bad` is slow.
2. Find the query in Query Store.
3. Inspect executions, logical reads, CPU, duration and plan.
4. Identify all tables and access operators.
5. Estimate whether the endpoint retrieves more data than required.
6. Only now open the EF Core code.
7. Compare with `/workshop4/customer/123/orders-good`.
8. Write symptom, evidence, root cause, fix and validation.

## Deliverable
Record observations, evidence and a short conclusion for the lab.