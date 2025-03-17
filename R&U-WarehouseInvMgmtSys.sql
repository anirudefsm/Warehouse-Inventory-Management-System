show databases;
use `Warehouse Inventory Management System`;
show tables;

-- This file contains 2 type of queries:-
-- 1. Retrieval and Analyse Queries
-- 2. Updation Queries

-- Categories Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Categories;
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID GROUP BY c.CategoryID;
SELECT * FROM Categories WHERE CategoryDescription LIKE '%electronics%';
SELECT CategoryName, LENGTH(CategoryDescription) AS DescriptionLength FROM Categories ORDER BY DescriptionLength DESC LIMIT 5;
SELECT c.CategoryName FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID WHERE p.ProductID IS NULL;
SELECT * from Categories where CategoryDescription like '%and%' and CategoryDescription like '%personal%';

-- -- 2. Updation Queries
UPDATE Categories SET CategoryDescription = 'Updated description' WHERE CategoryID = 1;
UPDATE Categories SET CategoryName = 'New Category Name' WHERE CategoryID = 2;
UPDATE Categories
SET CategoryDescription = CONCAT('Important: ', COALESCE(CategoryDescription, 'No Description'))
WHERE CategoryID = 5;
UPDATE Categories SET CategoryName = 'Unknown Category' WHERE CategoryDescription IS NULL;

-- Suppliers Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Suppliers;
SELECT s.SupplierName, COUNT(p.ProductID) AS ProductCount FROM Suppliers s LEFT JOIN Products p ON s.SupplierID = p.SupplierID GROUP BY s.SupplierID;
SELECT * FROM Suppliers WHERE ContactEmail LIKE '%@techtronics.com';
SELECT SupplierName, (LENGTH(ContactPerson) + LENGTH(ContactEmail) + LENGTH(ContactPhone) + LENGTH(Address)) AS ContactInfoLength FROM Suppliers ORDER BY ContactInfoLength DESC LIMIT 5;
SELECT * FROM Suppliers WHERE SupplierName REGEXP '^[AEIOU]';
SELECT LEFT(ContactPhone, 3) AS AreaCode, COUNT(*) AS Count FROM Suppliers GROUP BY LEFT(ContactPhone, 3) HAVING COUNT(*) > 1;

-- -- 2. Updation Queries
UPDATE Suppliers SET Address = 'New Supplier Address' WHERE SupplierID = 1;
UPDATE Suppliers SET ContactPhone = '111-222-3443' WHERE SupplierID = 2;

UPDATE Suppliers
SET ContactPhone = REGEXP_REPLACE(ContactPhone, '[^0-9]', '')
WHERE ContactPhone IS NOT NULL AND ContactPhone REGEXP '[^0-9]';

UPDATE Suppliers
SET ContactPerson = UPPER(ContactPerson)
WHERE ContactPerson IS NOT NULL;

-- Products Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Products;
SELECT * FROM Products WHERE ReorderLevel < 10;
SELECT c.CategoryName, AVG(p.ReorderLevel) AS AvgReorderLevel FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID GROUP BY c.CategoryID;
SELECT c.CategoryName, p.ProductName, p.ReorderLevel FROM Products p JOIN Categories c ON p.CategoryID = c.CategoryID WHERE p.ReorderLevel = (SELECT MAX(ReorderLevel) FROM Products WHERE CategoryID = c.CategoryID);
SELECT ProductName FROM Products GROUP BY ProductName HAVING count(SupplierID) > 1;
SELECT AVG(LENGTH(Description)) from Products;

-- -- 2. Updation Queries
UPDATE Products SET ReorderLevel = 15 WHERE ProductID = 1;
UPDATE Products SET CategoryID = 3 WHERE ProductID = 2;
UPDATE Products SET ReorderLevel = ReorderLevel * 1.1 WHERE CategoryID = 1;
UPDATE Products SET Description = 'No description available' WHERE Description IS NULL;

-- Locations Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Locations;
SELECT l.LocationName, COUNT(i.ProductID) AS ProductCount FROM Locations l LEFT JOIN Inventory i ON l.LocationID = i.LocationID GROUP BY l.LocationID;
SELECT * from Locations where WarehouseArea like "%Electronics%";
SELECT LocationName, LENGTH(LocationName) AS NameLength FROM Locations ORDER BY NameLength DESC LIMIT 5;
SELECT * from Locations where LocationName like '%Aisle%' and LocationName like '%Shelf%';
SELECT WarehouseArea, count(*) from Locations group by WarehouseArea order by count(*) DESC limit 1;

-- -- 2. Updation Queries
UPDATE Locations SET WarehouseArea = 'Updated Area' WHERE LocationID = 1;
UPDATE Locations SET LocationName = 'New Location Name' WHERE LocationID = 2;
UPDATE Locations SET LocationName = CONCAT('WH-', LocationName) WHERE LocationID > 0;
UPDATE Locations SET WarehouseArea = 'General Storage' WHERE WarehouseArea IS NULL;

-- Inventory Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Inventory;
SELECT * FROM Inventory WHERE QuantityOnHand < 30;
SELECT SUM(i.QuantityOnHand * p.ReorderLevel) AS TotalInventoryValue FROM Inventory i JOIN Products p ON i.ProductID = p.ProductID;
SELECT p.ProductName, i.QuantityOnHand * p.ReorderLevel AS InventoryValue FROM Inventory i JOIN Products p ON i.ProductID = p.ProductID ORDER BY InventoryValue DESC LIMIT 5;
SELECT p.ProductName from Inventory i JOIN products p on i.ProductID = p.ProductID GROUP BY i.ProductID HAVING count(DISTINCT i.LocationID) = (select count(*) from Locations);
SELECT p.ProductName, AVG(i.QuantityOnHand) from Inventory i JOIN Products p on i.ProductID = p.ProductID GROUP BY i.ProductID;

-- -- 2. Updation Queries
UPDATE Inventory SET QuantityOnHand = 100 WHERE InventoryID = 1;
UPDATE Inventory SET LastUpdated = NOW() WHERE InventoryID = 2;
UPDATE Inventory SET QuantityOnHand = QuantityOnHand * 1.2 WHERE LocationID = 1;
UPDATE Inventory SET QuantityOnHand = 0 where QuantityOnHand IS NULL;

-- Shipments Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Shipments;
SELECT * FROM Shipments WHERE Status = 'Shipped';
SELECT AVG(DATEDIFF(ExpectedDeliveryDate, ShipmentDate)) AS AvgDeliveryTime FROM Shipments;
SELECT ShipmentID, LENGTH(TrackingNumber) AS TrackingNumberLength FROM Shipments ORDER BY TrackingNumberLength DESC LIMIT 5;
SELECT * from Shipments where ExpectedDeliveryDate < ShipmentDate;
SELECT Status, count(*) from Shipments group by Status order by count(*) DESC limit 1;

-- -- 2. Updation Queries
UPDATE Shipments SET Status = 'Delivered' WHERE ShipmentID = 1;
UPDATE Shipments SET ExpectedDeliveryDate = '2023-12-31' WHERE ShipmentID = 2;
UPDATE Shipments SET TrackingNumber = CONCAT('SHIP-', TrackingNumber) WHERE ShipmentID > 0;
UPDATE Shipments SET ExpectedDeliveryDate = DATE_ADD(ShipmentDate, INTERVAL 7 DAY) where ExpectedDeliveryDate IS NULL;

-- Customers Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Customers;
SELECT * FROM Customers WHERE CustomerEmail LIKE '%@example.com';
SELECT c.CustomerName, COUNT(o.OrderID) AS OrderCount FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID GROUP BY c.CustomerID;
SELECT CustomerName, LENGTH(CustomerName) AS NameLength FROM Customers ORDER BY NameLength DESC LIMIT 5;
SELECT CustomerPhone, count(*) from Customers group by LEFT(CustomerPhone,3) having count(*) > 1;
SELECT AVG(LENGTH(CustomerAddress)) from Customers;

-- -- 2. Updation Queries
UPDATE Customers SET CustomerAddress = 'New Customer Address' WHERE CustomerID = 1;
UPDATE Customers SET CustomerPhone = '111-222-3333' WHERE CustomerID = 2;
UPDATE Customers SET CustomerEmail = LOWER(CustomerEmail) WHERE CustomerEmail IS NOT NULL;
UPDATE Customers SET CustomerName = UPPER(CustomerName) WHERE CustomerName IS NOT NULL;

-- Orders Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Orders;
SELECT * FROM Orders WHERE OrderStatus = 'Pending';
SELECT o.OrderID, SUM(oi.Quantity * oi.UnitPrice) AS TotalOrderValue FROM Orders o JOIN OrderItems oi ON o.OrderID = oi.OrderID GROUP BY o.OrderID;
SELECT OrderID, LENGTH(DeliveryAddress) AS AddressLength FROM Orders ORDER BY AddressLength DESC LIMIT 5;
SELECT * from Orders where DAYOFWEEK(OrderDate) IN (1,7);
SELECT OrderStatus, count(*) from Orders group by OrderStatus order by count(*) DESC limit 1;

-- -- 2. Updation Queries
UPDATE Orders SET OrderStatus = 'Completed' WHERE OrderID = 1;
UPDATE Orders SET DeliveryAddress = 'New Delivery Address' WHERE OrderID = 2;
UPDATE Orders SET DeliveryAddress = CONCAT('DELIVER TO: ', DeliveryAddress) WHERE OrderID > 0;
UPDATE Orders SET OrderStatus = 'Pending' where OrderStatus IS NULL;

-- OrderItems Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM OrderItems;
SELECT p.ProductName, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales FROM OrderItems oi JOIN Products p ON oi.ProductID = p.ProductID GROUP BY oi.ProductID;
SELECT * from OrderItems where Quantity > 5;
SELECT OrderItemID, Quantity * UnitPrice AS TotalValue FROM OrderItems ORDER BY TotalValue DESC LIMIT 5;
SELECT p.ProductName FROM OrderItems oi JOIN products p on oi.ProductID = p.ProductID GROUP BY oi.ProductID HAVING count(DISTINCT oi.OrderID) > 1;
SELECT AVG(Quantity) FROM OrderItems;

-- -- 2. Updation Queries
UPDATE OrderItems SET Quantity = 5 WHERE OrderItemID = 1;
UPDATE OrderItems SET UnitPrice = 10.50 WHERE OrderItemID = 2;
UPDATE OrderItems SET UnitPrice = UnitPrice * 1.1 WHERE OrderItemID > 0;

-- Employees Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Employees;
SELECT * FROM Employees WHERE HireDate > '2021-01-01';
SELECT JobTitle, COUNT(*) AS EmployeeCount FROM Employees GROUP BY JobTitle;
SELECT FirstName, LENGTH(LastName) from Employees order by LENGTH(LastName) DESC limit 5;
SELECT Email, count(*) from Employees group by SUBSTRING_INDEX(Email, '@', -1) having count(*) > 1;
SELECT AVG(DATEDIFF(CURDATE(), HireDate)) from Employees;

-- -- 2. Updation Queries
UPDATE Employees SET JobTitle = 'Senior Clerk' WHERE EmployeeID = 1;
UPDATE Employees SET Email = 'new.email@example.com' WHERE EmployeeID = 2;
UPDATE Employees SET Email = LOWER(Email) WHERE Email IS NOT NULL;
UPDATE Employees SET JobTitle = 'Manager' WHERE HireDate IS NULL;

-- Adjustments Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Adjustments;
SELECT * FROM Adjustments WHERE ProductID = 1;
SELECT p.ProductName, SUM(a.QuantityChange) AS TotalQuantityChange FROM Adjustments a JOIN Products p ON a.ProductID = p.ProductID GROUP BY a.ProductID;
SELECT AdjustmentID, ABS(QuantityChange) from Adjustments order by ABS(QuantityChange) DESC limit 5;
SELECT Reason, count(*) from Adjustments group by Reason having count(*) > 1;
SELECT AVG(QuantityChange) from Adjustments;

-- -- 2. Updation Queries
UPDATE Adjustments SET Reason = 'Updated Reason' WHERE AdjustmentID = 1;
UPDATE Adjustments SET QuantityChange = 100 where AdjustmentID = 2;
UPDATE Adjustments SET Reason = CONCAT('Important: ', Reason) WHERE AdjustmentID > 0;
UPDATE Adjustments SET QuantityChange = 0 where QuantityChange IS NULL;

-- PurchaseOrders Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM PurchaseOrders;
SELECT * FROM PurchaseOrders WHERE SupplierID = 18;
SELECT po.PurchaseOrderID, SUM(poi.Quantity * poi.UnitPrice) AS TotalPurchaseOrderValue FROM PurchaseOrders po JOIN PurchaseOrderItems poi ON po.PurchaseOrderID = poi.PurchaseOrderID GROUP BY po.PurchaseOrderID;
SELECT PurchaseOrderID, DATEDIFF(ExpectedDeliveryDate, OrderDate) from PurchaseOrders order by DATEDIFF(ExpectedDeliveryDate, OrderDate) DESC limit 5;
SELECT OrderStatus, count(*) from PurchaseOrders group by OrderStatus having count(*) > 1;
SELECT AVG(DATEDIFF(ExpectedDeliveryDate, OrderDate)) from PurchaseOrders;

-- -- 2. Updation Queries
UPDATE PurchaseOrders SET OrderStatus = 'Received' WHERE PurchaseOrderID = 19;
UPDATE PurchaseOrders SET ExpectedDeliveryDate = '2023-12-31' WHERE PurchaseOrderID = 20;
UPDATE PurchaseOrders SET OrderStatus = UPPER(OrderStatus) WHERE PurchaseOrderID > 0;
UPDATE PurchaseOrders SET ExpectedDeliveryDate = OrderDate where ExpectedDeliveryDate IS NULL;

-- PurchaseOrderItems Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM PurchaseOrderItems;
SELECT p.ProductName, SUM(poi.Quantity * poi.UnitPrice) AS TotalPurchaseSales FROM PurchaseOrderItems poi JOIN Products p ON poi.ProductID = p.ProductID GROUP BY poi.ProductID;
SELECT PurchaseOrderItemID, Quantity * UnitPrice AS TotalValue from PurchaseOrderItems order by Quantity * UnitPrice DESC limit 5;
SELECT p.ProductName from PurchaseOrderItems poi JOIN Products p on poi.ProductID = p.ProductID GROUP BY poi.ProductID HAVING count(DISTINCT poi.PurchaseOrderID) > 1;
SELECT AVG(Quantity) from PurchaseOrderItems;

-- -- 2. Updation Queries
UPDATE PurchaseOrderItems SET Quantity = 15 WHERE PurchaseOrderItemID = 1;
UPDATE PurchaseOrderItems SET UnitPrice = UnitPrice * 1.1 WHERE PurchaseOrderItemID > 0;
UPDATE PurchaseOrderItems SET UnitPrice = 0 where UnitPrice IS NULL;
UPDATE PurchaseOrderItems SET Quantity = Quantity + 5 where PurchaseOrderID = 1;

-- CycleCounts Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM CycleCounts;
SELECT * FROM CycleCounts WHERE LocationID = 2;
SELECT cc.CycleCountID, SUM(cci.ActualQuantity - cci.SystemQuantity) AS TotalQuantityDifference FROM CycleCounts cc JOIN CycleCountItems cci ON cc.CycleCountID = cci.CycleCountID GROUP BY cc.CycleCountID;
SELECT CountDate, LENGTH(Notes) from CycleCounts order by LENGTH(Notes) DESC limit 5;
SELECT EmployeeID, count(*) from CycleCounts group by EmployeeID having count(*) > 1;
SELECT AVG(DATEDIFF(CountDate, CURDATE())) from CycleCounts;

-- -- 2. Updation Queries
UPDATE CycleCounts SET Notes = 'Updated notes' WHERE CycleCountID = 3;
UPDATE CycleCounts SET CountDate = NOW() WHERE CycleCountID = 4;
UPDATE CycleCounts SET Notes = CONCAT('Important: ', Notes) WHERE CycleCountID > 0;
UPDATE CycleCounts SET CountDate = DATE_ADD(CountDate, INTERVAL 1 DAY) where CountDate is NULL;

-- CycleCountItems Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM CycleCountItems;
SELECT * FROM CycleCountItems WHERE CycleCountID = 4;
SELECT p.ProductName, SUM(cci.ActualQuantity - cci.SystemQuantity) AS TotalQuantityDifference FROM CycleCountItems cci JOIN Products p ON cci.ProductID = p.ProductID GROUP BY cci.ProductID;
SELECT CycleCountItemID, ABS(ActualQuantity - SystemQuantity) from CycleCountItems order by ABS(ActualQuantity - SystemQuantity) DESC limit 5;
SELECT ProductID, count(*) from CycleCountItems group by ProductID having count(*) > 1;
SELECT AVG(ActualQuantity - SystemQuantity) from CycleCountItems;

-- -- 2. Updation Queries
UPDATE CycleCountItems SET ActualQuantity = 100 WHERE CycleCountItemID = 5;
UPDATE CycleCountItems SET SystemQuantity = ActualQuantity where SystemQuantity IS NULL;
UPDATE CycleCountItems SET ActualQuantity = ActualQuantity + 10 where CycleCountID = 1;
UPDATE CycleCountItems SET SystemQuantity = 0 where SystemQuantity < 0;

-- Returns Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM Returns;
SELECT * FROM Returns WHERE OrderID = 5;
SELECT r.ReturnID, SUM(ri.Quantity) AS TotalReturnedQuantity FROM Returns r JOIN ReturnItems ri ON r.ReturnID = ri.ReturnID GROUP BY r.ReturnID;
SELECT ReturnDate, LENGTH(Reason) from Returns order by LENGTH(Reason) DESC limit 5;
SELECT Reason, count(*) from Returns group by Reason having count(*) > 1;
SELECT AVG(DATEDIFF(ReturnDate, CURDATE())) from Returns;

-- -- 2. Updation Queries
UPDATE Returns SET ReturnStatus = 'Processed' WHERE ReturnID = 6;
UPDATE Returns SET ReturnDate = NOW() where ReturnID = 7;
UPDATE Returns SET Reason = CONCAT('Important: ', Reason) WHERE ReturnID > 0;
UPDATE Returns SET ReturnDate = DATE_ADD(ReturnDate, INTERVAL 1 DAY) where ReturnDate IS NULL;

-- ReturnItems Table Queries
-- -- 1. Retrieval and Analyse Queries
SELECT * FROM ReturnItems;
SELECT * FROM ReturnItems WHERE ReturnID = 6;
SELECT p.ProductName, SUM(ri.Quantity) AS TotalReturnedQuantity FROM ReturnItems ri JOIN Products p ON ri.ProductID = p.ProductID GROUP BY ri.ProductID;
SELECT ReturnItemID, Quantity from ReturnItems order by Quantity DESC limit 5;
SELECT ProductID, count(*) from ReturnItems group by ProductID having count(*) > 1;
SELECT AVG(Quantity) from ReturnItems;

-- -- 2. Updation Queries
UPDATE ReturnItems SET Quantity = 2 WHERE ReturnItemID = 7;
UPDATE ReturnItems SET Quantity = 0 where Quantity IS NULL;
UPDATE ReturnItems SET Quantity = Quantity + 3 where ReturnID = 1;
UPDATE ReturnItems SET ProductID = 1 where ProductID IS NULL;



-- Insightful Analysis Queries with Joins

-- 1. Category Performance Analysis:
-- Identify categories with the highest sales and analyze their average reorder levels.
SELECT c.CategoryName, SUM(oi.Quantity * oi.UnitPrice) AS TotalSales, AVG(p.ReorderLevel) AS AvgReorderLevel
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY c.CategoryName
ORDER BY TotalSales DESC;

-- 2. Customer Purchasing Trends:
-- Analyze the average order value for each customer and identify high-value customers.
SELECT c.CustomerName, AVG(oi.Quantity * oi.UnitPrice) AS AvgOrderValue, COUNT(o.OrderID) as OrderCount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerName
ORDER BY AvgOrderValue DESC;

-- 3. Supplier Performance in Order Fulfillment:
-- Analyze the average time taken by each supplier to fulfill purchase orders.
SELECT s.SupplierName, AVG(TIMESTAMPDIFF(DAY, po.OrderDate, po.ExpectedDeliveryDate)) AS AvgFulfillmentDays
FROM Suppliers s
JOIN PurchaseOrders po ON s.SupplierID = po.SupplierID
GROUP BY s.SupplierName;

-- 4. Cycle Count Accuracy:
-- Calculate the average percentage difference between system and actual quantities for each product.
SELECT p.ProductName, AVG(ABS(cci.ActualQuantity - cci.SystemQuantity) / cci.SystemQuantity * 100) AS AvgPercentageDifference
FROM Products p
JOIN CycleCountItems cci ON p.ProductID = cci.ProductID
GROUP BY p.ProductName;

-- 5. Inventory Adjustment Reasons:
-- Analyze the frequency of different inventory adjustment reasons.
SELECT a.Reason, COUNT(*) AS AdjustmentCount
FROM Adjustments a
GROUP BY a.Reason
ORDER BY AdjustmentCount DESC;

-- 6. Location Stock Analysis:
-- Find locations with the highest and lowest product availability, and identify the products.
SELECT l.LocationName, SUM(i.QuantityOnHand) AS TotalQuantityOnHand, p.ProductName
FROM Locations l
JOIN Inventory i ON l.LocationID = i.LocationID
JOIN Products p ON i.ProductID = p.ProductID
GROUP BY l.LocationName, p.ProductName
ORDER BY TotalQuantityOnHand DESC;

-- 7. Category Return Rate:
-- Find categories with the highest return rates.
SELECT c.CategoryName, COUNT(ri.ReturnItemID) / COUNT(oi.OrderItemID) as ReturnRate
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
LEFT JOIN ReturnItems ri ON p.ProductID = ri.ProductID
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY c.CategoryID
ORDER BY ReturnRate DESC;

-- 8. Customer Lifetime Value (CLTV) Analysis:
-- Estimate the total value a customer brings over their relationship with the company.
SELECT c.CustomerName, SUM(oi.Quantity * oi.UnitPrice) AS CLTV
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID
ORDER BY CLTV DESC;

-- 9. Product Category Profitability:
-- Calculate the profit generated by each product category (assuming purchase cost is tracked).
SELECT c.CategoryName, SUM((oi.UnitPrice - poi.UnitPrice) * oi.Quantity) as Profit
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderItems oi ON p.ProductID = oi.ProductID
JOIN PurchaseOrderItems poi ON p.ProductID = poi.ProductID
WHERE oi.OrderID = poi.PurchaseOrderID
GROUP BY c.CategoryName
ORDER BY Profit DESC;

-- 10. Customer Order Patterns (Day of Week):
-- Analyze which days of the week customers place the most orders.
SELECT DAYNAME(o.OrderDate) AS OrderDay, COUNT(o.OrderID) AS OrderCount
FROM Orders o
GROUP BY DAYNAME(o.OrderDate)
ORDER BY OrderCount DESC;

-- 11. Inventory Turnover Rate per Category:
-- Calculate how many times inventory is sold and replaced in a given period, per category.
SELECT c.CategoryName, SUM(oi.Quantity) / AVG(i.QuantityOnHand) AS InventoryTurnoverRate
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderItems oi ON p.ProductID = oi.ProductID
JOIN Inventory i ON p.ProductID = i.ProductID
GROUP BY c.CategoryName;