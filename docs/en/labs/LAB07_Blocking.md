# LAB07 — Blocking Caused by Application Transaction

## Objective
Diagnose blocking caused by a transaction that remains open too long.

## Time
40 min.

## Before you start
- The API and database must be running.
- Use `src/Workshop.Api/Workshop.Api.http`; the two requests must overlap.
- Open a second SQL window in VS Code for requests and lock diagnostics.

## Steps
1. Call `POST /workshop3/blocking/1`.
2. **Immediately**, within 30 s, call `POST /workshop3/update/1?status=Completed`.
3. While the second request is waiting, inspect `sys.dm_exec_requests` and `sys.dm_tran_locks` in VS Code.
4. Identify the blocker and blocked session.
5. Find `Task.Delay(30s)` inside the application transaction.
6. Propose a shorter transaction scope.

## What to record
- blocker and blocked `session_id`,
- `wait_type` and `blocking_session_id`,
- lock modes and resource type,
- transaction lifetime,
- root cause and proposed fix.

## Exit criterion
You can show active blocking, identify both sessions, and explain why the second request waits while the application transaction remains open.

## If the result is different
- The second request returns immediately: retry and start it sooner.
- No wait is visible: run diagnostics while the request is still blocked.
- Timing is difficult in Swagger: use the paired requests in `Workshop.Api.http`.

## Questions
- Is SQL Server the cause, or where the problem becomes visible?
- Which operations should not be held inside a long transaction?
- Why can the blocked request wait on SELECT before UPDATE?

## Worksheet
Fill [../worksheets/LAB07_WORKSHEET.md](../worksheets/LAB07_WORKSHEET.md).
