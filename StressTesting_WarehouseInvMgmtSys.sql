show databases;
use `Warehouse Inventory Management System`;
show tables;

-- Stresstesting for 1NF (1st Normal Form)

-- To check if a table follows First Normal Form (1NF) in SQL, you need to ensure that:
-- 1. Each column contains atomic values (no multiple values in a single column).
-- 2. Each row has a unique identifier (a primary key is defined).
-- 3. All columns store only single-valued attributes (no repeating groups or arrays).


-- Check for Atomicity

-- Categories Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Categories
WHERE CategoryName LIKE '%,%'
   OR CategoryDescription LIKE '%,%';

-- Suppliers Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Suppliers
WHERE SupplierName LIKE '%,%'
   OR ContactPhone LIKE '%,%'
   OR ContactEmail LIKE '%,%'
   OR Address LIKE '%,%';

-- Products Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Products
WHERE ProductName LIKE '%,%'
   OR Description LIKE '%,%';

-- Locations Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Locations
WHERE LocationName LIKE '%,%'
   OR WarehouseArea LIKE '%,%';

-- Inventory Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Inventory
WHERE InventoryID IN (
    SELECT InventoryID FROM Inventory
    JOIN Products ON Inventory.ProductID = Products.ProductID
    WHERE Products.ProductName LIKE '%,%'
    OR Products.Description LIKE '%,%'
    OR Inventory.QuantityOnHand LIKE '%,%'
    OR Products.ReorderLevel LIKE '%,%'
);

-- Shipments Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Shipments
WHERE TrackingNumber LIKE '%,%'
   OR Status LIKE '%,%';

-- Customers Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Customers
WHERE CustomerName LIKE '%,%'
   OR CustomerAddress LIKE '%,%'
   OR CustomerPhone LIKE '%,%'
   OR CustomerEmail LIKE '%,%';

-- Orders Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Orders
WHERE DeliveryAddress LIKE '%,%'
   OR OrderStatus LIKE '%,%';

-- OrderItems Table:
-- Check for Multi-Valued Attributes
SELECT * FROM OrderItems
WHERE Quantity LIKE '%,%'
   OR UnitPrice LIKE '%,%';

-- Employees Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Employees
WHERE FirstName LIKE '%,%'
   OR LastName LIKE '%,%'
   OR Email LIKE '%,%'
   OR JobTitle LIKE '%,%';

-- Adjustments Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Adjustments
WHERE Reason LIKE '%,%'
   OR QuantityChange LIKE '%,%';

-- PurchaseOrders Table:
-- Check for Multi-Valued Attributes
SELECT * FROM PurchaseOrders
WHERE OrderStatus LIKE '%,%';

-- PurchaseOrderItems Table:
-- Check for Multi-Valued Attributes
SELECT * FROM PurchaseOrderItems
WHERE Quantity LIKE '%,%'
   OR UnitPrice LIKE '%,%';

-- CycleCounts Table:
-- Check for Multi-Valued Attributes
SELECT * FROM CycleCounts
WHERE Notes LIKE '%,%';

-- CycleCountItems Table:
-- Check for Multi-Valued Attributes
SELECT * FROM CycleCountItems
WHERE ActualQuantity LIKE '%,%'
   OR SystemQuantity LIKE '%,%';

-- Returns Table:
-- Check for Multi-Valued Attributes
SELECT * FROM Returns
WHERE Reason LIKE '%,%'
   OR ReturnStatus LIKE '%,%';

-- ReturnItems Table:
-- Check for Multi-Valued Attributes
SELECT * FROM ReturnItems
WHERE Quantity LIKE '%,%';

-- no column in any table contains multiple values separated by comma, so, 1NF is not violated. 


-- Check for Missing Primary Keys
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'Warehouse Inventory Management System' 
AND TABLE_NAME NOT IN (
    SELECT DISTINCT TABLE_NAME
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE CONSTRAINT_NAME = 'PRIMARY'
);

-- There are no tables with missing primary keys, so, 1NF is not violated.


-- Check for Repeating Groups
SELECT COLUMN_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Warehouse Inventory Management System' 
AND COLUMN_NAME REGEXP '_[0-9]$';

-- As no column names end with _1, _2, _3, etc., 1NF is not violated.

-- As, all checks for 1NF found that, 1NF is not violated, hence we can conclude that our database - Warehouse Inventory Management System - is 1NF compliant.