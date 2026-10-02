# LAB12 — Final Challenge: Developer Meets DBA

## Objective
Bring together every element of the workshop in one evidence-based diagnosis.

## Time
Use the time allocated by the instructor. This is the final evidence-based challenge for the 3-day track.

## Before you start
- LAB01–LAB11 should be complete or at least discussed.
- Prepare your worksheets and evidence from earlier labs.
- Do not start from the C# code; start from symptoms and SQL Server evidence.

## Scenario
> The API works correctly from a functional standpoint, but under load response time grows and timeouts occur.

## Tasks
Review the relevant endpoints and SQL Server evidence: execution plans, Query Store, logical reads, waits, blocking, locks, and indexes.

Classify each finding as **Application / Database / Both** and assign **Impact** and **Effort** as Low / Medium / High.

## Report
| Problem | Evidence | Layer | Fix | Priority |
|---|---|---|---|---|
| Over-fetching |  |  |  |  |
| Missing index |  |  |  |  |
| Non-SARGable predicate |  |  |  |  |
| Long transaction |  |  |  |  |
| N+1 |  |  |  |  |

## What to record
- at least five findings,
- evidence for every conclusion,
- Application / Database / Both classification,
- Impact and Effort,
- proposed fix and validation method.

## Exit criterion
You can present a short diagnosis in which every recommendation has evidence, an ownership layer, and a priority.

## If the result is different
- A problem no longer reproduces: use evidence captured in the earlier lab instead of spending the whole capstone reproducing it.
- The group disagrees about ownership: justify the classification from evidence; some findings legitimately belong to Both.
- Time is short: prioritize High Impact with Low/Medium Effort.

## Final question
**What really reaches SQL Server?**

Write your own one-sentence answer and support it with at least two pieces of evidence collected during the course.

## Worksheet
Fill [../worksheets/LAB12_WORKSHEET.md](../worksheets/LAB12_WORKSHEET.md).
