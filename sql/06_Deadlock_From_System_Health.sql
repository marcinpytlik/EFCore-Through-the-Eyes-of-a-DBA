USE master;
GO

/*
    LAB09 helper: read recent deadlock reports from the built-in
    system_health Extended Events session.

    Run this after reproducing the deadlock. The newest row should
    contain an xml_deadlock_report event. Save deadlock_xml as .xdl
    if you want to visualize the graph.
*/

DECLARE @xel_path nvarchar(4000);

SELECT @xel_path =
    CAST(t.target_data AS xml).value(
        '(EventFileTarget/File/@name)[1]',
        'nvarchar(4000)')
FROM sys.dm_xe_sessions AS s
JOIN sys.dm_xe_session_targets AS t
    ON t.event_session_address = s.address
WHERE s.name = N'system_health'
  AND t.target_name = N'event_file';

IF @xel_path IS NULL
BEGIN
    THROW 50000, 'Could not resolve the system_health event-file path.', 1;
END;

SELECT TOP (10)
    timestamp_utc,
    CAST(event_data AS xml) AS deadlock_xml
FROM sys.fn_xe_file_target_read_file(@xel_path, NULL, NULL, NULL)
WHERE object_name = N'xml_deadlock_report'
ORDER BY timestamp_utc DESC;
GO
