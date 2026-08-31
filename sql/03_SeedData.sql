USE EfCoreDbaLab;
GO
SET NOCOUNT ON;

-- 5,000 customers
;WITH n AS
(
    SELECT TOP (5000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT dbo.Customers(Name, Email, City, CreatedAt)
SELECT
    CONCAT(N'Customer ', rn),
    CONCAT(N'customer', rn, N'@example.com'),
    CONCAT(N'City ', ((rn - 1) % 50) + 1),
    DATEADD(day, -(rn % 1000), SYSUTCDATETIME())
FROM n;
GO

-- 100,000 orders
;WITH n AS
(
    SELECT TOP (100000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT dbo.Orders(CustomerId, OrderDate, Status, TotalAmount, Notes)
SELECT
    ((rn - 1) % 5000) + 1,
    DATEADD(minute, -(rn % 525600), SYSUTCDATETIME()),
    CASE rn % 4
        WHEN 0 THEN 'New'
        WHEN 1 THEN 'Processing'
        WHEN 2 THEN 'Completed'
        ELSE 'Cancelled'
    END,
    CONVERT(decimal(12,2), 10 + (rn % 20000) / 10.0),
    CASE WHEN rn % 10 = 0
         THEN REPLICATE(N'Lab order note. ', 20)
         ELSE NULL
    END
FROM n;
GO

-- 300,000 order lines
;WITH n AS
(
    SELECT TOP (300000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT dbo.OrderLines(OrderId, ProductName, Quantity, UnitPrice)
SELECT
    ((rn - 1) % 100000) + 1,
    CONCAT(N'Product ', ((rn - 1) % 500) + 1),
    ((rn - 1) % 5) + 1,
    CONVERT(decimal(12,2), 1 + (rn % 5000) / 10.0)
FROM n;
GO

/*
Hot customer 123 is used by LAB04–LAB12.
Extra orders + wide Notes make Include/ThenInclude and Key Lookup visible
without relying on wall-clock "several seconds" on a cold cache.
*/
DECLARE @HotCustomerId int = 123;

;WITH n AS
(
    SELECT TOP (1500)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT dbo.Orders(CustomerId, OrderDate, Status, TotalAmount, Notes)
SELECT
    @HotCustomerId,
    DATEADD(minute, -rn, SYSUTCDATETIME()),
    CASE rn % 4
        WHEN 0 THEN 'New'
        WHEN 1 THEN 'Processing'
        WHEN 2 THEN 'Completed'
        ELSE 'Cancelled'
    END,
    CONVERT(decimal(12,2), 50 + (rn % 5000) / 10.0),
    REPLICATE(N'Hot-customer incident note. ', 30)
FROM n;
GO

;WITH lines AS
(
    SELECT TOP (8)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS line_no
    FROM sys.all_objects
)
INSERT dbo.OrderLines(OrderId, ProductName, Quantity, UnitPrice)
SELECT
    o.OrderId,
    CONCAT(N'Hot product ', lines.line_no),
    lines.line_no,
    CONVERT(decimal(12,2), 9.99 * lines.line_no)
FROM dbo.Orders AS o
CROSS JOIN lines
WHERE o.CustomerId = 123
  AND o.Notes LIKE N'Hot-customer incident note.%';
GO

PRINT 'Seed complete.';
PRINT 'Hot customer 123 has a large order graph for incident labs.';
GO
