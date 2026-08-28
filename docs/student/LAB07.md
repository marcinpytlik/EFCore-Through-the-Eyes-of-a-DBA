# LAB07 — Blocking Caused by Application Transaction

## Objective
Diagnose blocking caused by a transaction held open by application code.

## Student Instructions
1. Call `POST /workshop3/blocking/1`.
2. Within 30 seconds call `POST /workshop3/update/1?status=Completed`.
3. Query `sys.dm_exec_requests` and inspect `blocking_session_id` and `wait_type`.
4. Inspect `sys.dm_tran_locks`.
5. Open the endpoint code and identify the delay inside the transaction.
6. Propose a shorter transaction scope.

## Deliverable
Record observations, evidence and a short conclusion for the lab.