# LAB05 — Covering Index and Key Lookup

## Objective
Understand why an Index Seek may still require extra lookups.

## Student Instructions
1. Keep the simple index on `Orders(CustomerId)`.
2. Run a query selecting OrderId, OrderDate, Status and TotalAmount.
3. Inspect the plan for Key Lookup.
4. Replace the index with one using INCLUDE columns.
5. Repeat the query and compare plan shape and logical reads.

## Deliverable
Record observations, evidence and a short conclusion for the lab.