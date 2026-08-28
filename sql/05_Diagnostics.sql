USE EfCoreDbaLab;
GO

-- Current requests / blocking
SELECT
    r.session_id,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.blocking_session_id,
    DB_NAME(r.database_id) AS database_name,
    t.text
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE r.session_id <> @@SPID
ORDER BY r.session_id;
GO

-- Locks in the lab database
SELECT
    request_session_id,
    resource_type,
    resource_description,
    request_mode,
    request_status
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID(N'EfCoreDbaLab')
ORDER BY request_session_id;
GO

-- Query Store: recent resource consumers
SELECT TOP (20)
    q.query_id,
    qt.query_sql_text,
    SUM(rs.count_executions) AS executions,
    CAST(SUM(rs.avg_duration * rs.count_executions) /
         NULLIF(SUM(rs.count_executions),0) / 1000.0 AS decimal(18,2)) AS avg_duration_ms,
    CAST(SUM(rs.avg_cpu_time * rs.count_executions) /
         NULLIF(SUM(rs.count_executions),0) / 1000.0 AS decimal(18,2)) AS avg_cpu_ms,
    CAST(SUM(rs.avg_logical_io_reads * rs.count_executions) /
         NULLIF(SUM(rs.count_executions),0) AS decimal(18,2)) AS avg_logical_reads
FROM sys.query_store_query_text AS qt
JOIN sys.query_store_query AS q
    ON q.query_text_id = qt.query_text_id
JOIN sys.query_store_plan AS p
    ON p.query_id = q.query_id
JOIN sys.query_store_runtime_stats AS rs
    ON rs.plan_id = p.plan_id
GROUP BY q.query_id, qt.query_sql_text
ORDER BY avg_logical_reads DESC;
GO
