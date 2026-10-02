# Day 3 — Query Store and Real Workload Diagnosis

## Goal

Move from a user-visible symptom to measurable workload evidence, root cause, fix and validation.

## Start of day

1. Start the database and API.
2. Verify Query Store is available.
3. Open `sql/05_Diagnostics.sql`.
4. Open `Workshop4Endpoints.cs`, but do not start the incident lab from the C# source.
5. Keep the API log visible.

## Labs

### LAB10 — Query Store Basics
Find application workload in Query Store by SQL shape and execution pattern.

[Open LAB10](labs/LAB10_Query_Store_Basics.md)

### LAB11 — Incident Investigation
Start from the symptom and database evidence, then move back to the code.

[Open LAB11](labs/LAB11_Incident_Investigation.md)

### LAB12 — Final Challenge: Developer Meets DBA
Combine plans, reads, Query Store, waits, locks and application evidence into one diagnosis.

[Open LAB12](labs/LAB12_Final_Challenge.md)

## Final diagnostic workflow

Use this sequence:

```text
Symptom
  ↓
Evidence
  ↓
Root cause
  ↓
Fix
  ↓
Validation
```

## Final checkpoint

You should be able to defend every recommendation with evidence.

For each finding, answer:

- What is the symptom?
- What evidence supports the diagnosis?
- Is the ownership Application / Database / Both?
- What change would you make?
- How would you prove the change improved the workload?
