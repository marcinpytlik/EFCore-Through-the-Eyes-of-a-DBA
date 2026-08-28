# LAB03 — Over-fetching vs Projection

## Objective
Compare full entity loading with projection of only required data.

## Student Instructions
1. Call `/workshop1/customers-bad` and inspect the generated SELECT list.
2. Call `/workshop1/customers-good` and inspect the generated SELECT list.
3. Compare result shape and HTTP payload size.
4. Use `SET STATISTICS IO ON` and `SET STATISTICS TIME ON` in SSMS.
5. Modify the good projection to add `City` without materializing the full entity.

## Deliverable
Record observations, evidence and a short conclusion for the lab.