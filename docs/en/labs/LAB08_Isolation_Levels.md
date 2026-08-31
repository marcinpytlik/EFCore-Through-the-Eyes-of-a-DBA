# LAB08 — Isolation Levels

## Objective
Observe how isolation level changes concurrent reads using the EF Core API and manual T-SQL.

## Time
35 min.

## Before you start
- The API and database must be running.
- Prepare the two LAB08 requests in `Workshop.Api.http`.
- For the fallback use two SQL sessions in VS Code or another SQL client.

## Variant A — EF Core (preferred)
1. Start `POST /workshop3/isolation/hold/10` and leave it in flight.
2. Before the 30-second hold finishes, call `GET /workshop3/isolation/read-committed/10` and record the behaviour.
3. Start the hold again, then call `GET /workshop3/isolation/read-uncommitted/10`.
4. After rollback, call `read-committed` again and record the durable value.

## Variant B — Manual T-SQL fallback
Use two separate SQL sessions. In Session A begin a transaction, update `OrderId = 10` to `Status = 'Processing'`, and leave the transaction open. In Session B compare a normal SELECT with a read under `READ UNCOMMITTED`. Finish with `ROLLBACK` in Session A.

## What to record
- READ COMMITTED behaviour,
- READ UNCOMMITTED behaviour,
- value observed while the transaction is open,
- value after rollback,
- whether a dirty read occurred and why it is risky.

## Exit criterion
You can demonstrate the difference between waiting under READ COMMITTED and seeing an uncommitted value under READ UNCOMMITTED.

## If the result is different
- READ COMMITTED does not wait: the hold probably ended; retry faster.
- READ UNCOMMITTED does not show `Processing`: issue the read while the hold is still active.
- Manual T-SQL blocks later work: verify Session A executed `ROLLBACK`.

## Discussion
- What did Session B see under READ COMMITTED?
- What did it see under READ UNCOMMITTED?
- What is a dirty read?
- Why is `NOLOCK` not a universal blocking fix?

## Worksheet
Fill [../worksheets/LAB08_WORKSHEET.md](../worksheets/LAB08_WORKSHEET.md).
