# LAB06 — Query Shape and SARGability

## Objective
Show how query formulation can influence whether an index can be used efficiently.

## Student Instructions
1. Create `IX_Customers_Name`.
2. Run an equality predicate directly on Name.
3. Compare with a predicate that wraps Name in `UPPER()`.
4. Discuss the analogous LINQ expression using `ToUpper()`.
5. Propose a comparison that avoids applying a function to the indexed column.

## Deliverable
Record observations, evidence and a short conclusion for the lab.