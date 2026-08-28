# Student Workbook — EF Core Through the Eyes of a DBA

Record measurements and conclusions for all 12 labs.

> Prefer execution-plan shape, logical reads, row estimates, waits and Query Store evidence over fixed millisecond targets.

# LAB01 Worksheet — From HTTP Request to SQL Server

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Endpoint tested |  |
| Generated SQL captured |  |
| Main table |  |
| JOINs observed |  |
| Selected columns |  |
| Materialization method |  |
| What reaches SQL Server? |  |

## Evidence table

| Observation | Evidence | Conclusion |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB02 Worksheet — Deferred Execution

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| SQL executed during query composition? |  |
| Materialization method |  |
| SQL executed at materialization? |  |
| Additional predicate |  |
| Final SQL change |  |

## Evidence table

| Stage | Observation | Evidence | Conclusion |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB03 Worksheet — Over-fetching vs Projection

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| BAD selected columns |  |
| GOOD selected columns |  |
| BAD logical reads |  |
| GOOD logical reads |  |
| BAD elapsed time |  |
| GOOD elapsed time |  |
| Payload difference |  |

## Evidence table

| Metric | BAD | GOOD | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB04 Worksheet — Missing Index: Scan vs Seek

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Operator BEFORE |  |
| Operator AFTER |  |
| Logical reads BEFORE |  |
| Logical reads AFTER |  |
| CPU BEFORE |  |
| CPU AFTER |  |
| Elapsed BEFORE |  |
| Elapsed AFTER |  |
| Estimated rows |  |
| Actual rows |  |

## Evidence table

| Metric | Before | After | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB05 Worksheet — Covering Index and Key Lookup

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Key Lookup before? |  |
| Logical reads BEFORE |  |
| Logical reads AFTER |  |
| Lookup removed? |  |
| INCLUDE columns |  |
| Benefit |  |
| Trade-off |  |

## Evidence table

| Metric | Simple index | Covering index | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB06 Worksheet — Query Shape and SARGability

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Direct predicate operator |  |
| Function predicate operator |  |
| Direct logical reads |  |
| Function logical reads |  |
| Seek used? |  |
| Non-SARGable expression |  |
| Proposed rewrite |  |

## Evidence table

| Query form | Plan | Reads | Conclusion |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB07 Worksheet — Blocking Caused by Application Transaction

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Blocking session_id |  |
| Blocked session_id |  |
| wait_type |  |
| Lock mode |  |
| Resource type |  |
| Transaction duration |  |
| Root cause |  |
| Proposed fix |  |

## Evidence table

| Session | Status | Wait type | Blocked by | Evidence |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB08 Worksheet — Isolation Levels

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| READ COMMITTED behavior |  |
| READ UNCOMMITTED behavior |  |
| Dirty read observed? |  |
| Value before rollback |  |
| Value after rollback |  |
| Risk |  |

## Evidence table

| Isolation level | Observed behavior | Risk / conclusion |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB09 Worksheet — Deadlock

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Deadlock victim |  |
| SQL error |  |
| Session A held resource |  |
| Session A requested resource |  |
| Session B held resource |  |
| Session B requested resource |  |
| Cycle |  |
| Preventive fix |  |
| Retry strategy |  |

## Evidence table

| Session | First resource | Second resource | Outcome |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB10 Worksheet — Query Store Basics

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| query_id |  |
| Execution count |  |
| Avg duration |  |
| Avg CPU |  |
| Avg logical reads |  |
| Main tables |  |
| Most expensive query |  |
| Why expensive? |  |

## Evidence table

| query_id | Executions | Duration | CPU | Logical reads | Notes |
|---|---|---|---|---|---|
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB11 Worksheet — Incident Investigation

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Symptom |  |
| Query Store evidence |  |
| Plan evidence |  |
| Logical reads |  |
| CPU / duration |  |
| Root cause |  |
| Application issue? |  |
| Database issue? |  |
| Fix |  |
| Validation |  |

## Evidence table

| Step | Observation | Evidence | Decision |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---

# LAB12 Worksheet — Final Challenge: Developer Meets DBA

## Student

- Name: ______________________________
- Date: ______________________________
- Team / Group: ______________________

## Measurements and observations

| Item | Result |
|---|---|
| Problem 1 |  |
| Problem 2 |  |
| Problem 3 |  |
| Highest-impact finding |  |
| Fastest low-effort improvement |  |
| Application fixes |  |
| Database fixes |  |
| Cross-layer fixes |  |
| What really reaches SQL Server? |  |

## Evidence table

| Problem | Evidence | Layer | Impact | Effort | Fix | Priority |
|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |

## Root cause / interpretation

______________________________________________________________________________

## Proposed fix

______________________________________________________________________________

## Validation

How did you prove that the change improved the situation?

______________________________________________________________________________

## Final conclusion

______________________________________________________________________________


---
