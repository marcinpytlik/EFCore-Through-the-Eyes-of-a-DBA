# LAB04 — Missing Index: Scan vs Seek

## Objective
Observe how an index can change the execution plan without any C# code change.

## Student Instructions
1. Ensure the Workshop 2 solution indexes are not installed.
2. Call `/workshop2/orders/customer/123`.
3. Run the matching query in SSMS with Actual Execution Plan and STATISTICS IO/TIME.
4. Record access operator, logical reads, CPU, elapsed time, estimated rows and actual rows.
5. Create `IX_Orders_CustomerId`.
6. Repeat the same query and compare the measurements.

## Deliverable
Record observations, evidence and a short conclusion for the lab.