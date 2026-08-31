USE EfCoreDbaLab;
GO

IF OBJECT_ID(N'dbo.OrderLines', N'U') IS NOT NULL DROP TABLE dbo.OrderLines;
IF OBJECT_ID(N'dbo.Orders', N'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID(N'dbo.Customers', N'U') IS NOT NULL DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
    CustomerId     int IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Customers PRIMARY KEY,
    Name           nvarchar(150) NOT NULL,
    Email          nvarchar(250) NOT NULL,
    City           nvarchar(100) NOT NULL,
    CreatedAt      datetime2(0) NOT NULL
        CONSTRAINT DF_Customers_CreatedAt DEFAULT SYSUTCDATETIME()
);
GO

CREATE INDEX IX_Customers_Name
ON dbo.Customers(Name);
GO

CREATE TABLE dbo.Orders
(
    OrderId        int IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Orders PRIMARY KEY,
    CustomerId     int NOT NULL,
    OrderDate      datetime2(0) NOT NULL,
    Status         varchar(30) NOT NULL,
    TotalAmount    decimal(12,2) NOT NULL,
    Notes          nvarchar(1000) NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY(CustomerId) REFERENCES dbo.Customers(CustomerId)
);
GO

CREATE TABLE dbo.OrderLines
(
    OrderLineId    bigint IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_OrderLines PRIMARY KEY,
    OrderId        int NOT NULL,
    ProductName    nvarchar(200) NOT NULL,
    Quantity       int NOT NULL,
    UnitPrice      decimal(12,2) NOT NULL,

    CONSTRAINT FK_OrderLines_Orders
        FOREIGN KEY(OrderId) REFERENCES dbo.Orders(OrderId)
);
GO

/*
Workshop 2 baseline index:
- Customers(Name) exists so LAB06 can demonstrate non-SARGable Index Scan vs SARGable Index Seek.

Intentionally missing indexes:
- Orders(CustomerId)
- OrderLines(OrderId)

They are added during Workshop 2.
*/
