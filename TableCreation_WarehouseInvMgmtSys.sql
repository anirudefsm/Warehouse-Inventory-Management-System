CREATE DATABASE `Warehouse Inventory Management System`;
use `Warehouse Inventory Management System`;

-- Create the Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(255) UNIQUE NOT NULL,
    CategoryDescription TEXT
);

-- Create the Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    ContactEmail VARCHAR(255) UNIQUE,
    ContactPhone VARCHAR(20) UNIQUE,
    Address VARCHAR(255)
);

-- Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    SKU VARCHAR(50) UNIQUE NOT NULL,
    UnitOfMeasure VARCHAR(50) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    ReorderLevel INT DEFAULT 0,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create the Locations table
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY AUTO_INCREMENT,
    LocationName VARCHAR(255) UNIQUE NOT NULL,
    WarehouseArea VARCHAR(255)
);

-- Create the Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    LocationID INT NOT NULL,
    QuantityOnHand INT DEFAULT 0,
    LastUpdated DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (ProductID, LocationID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
);

-- Create the Shipments table
CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    ShipmentDate DATE NOT NULL,
    ExpectedDeliveryDate DATE,
    TrackingNumber VARCHAR(100) UNIQUE,
    Status VARCHAR(50),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(255) NOT NULL,
    CustomerAddress VARCHAR(255),
    CustomerEmail VARCHAR(255) UNIQUE,
    CustomerPhone VARCHAR(20) UNIQUE
);

-- Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    OrderStatus VARCHAR(50),
    ShipmentID INT,
    DeliveryAddress VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID)
);

-- Create the OrderItems table
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    JobTitle VARCHAR(100),
    Email VARCHAR(255) UNIQUE,
    PhoneNumber VARCHAR(20) UNIQUE,
    HireDate DATE
);

-- Create the Adjustments table
CREATE TABLE Adjustments (
    AdjustmentID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    LocationID INT NOT NULL,
    AdjustmentDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    QuantityChange INT NOT NULL,
    Reason VARCHAR(255),
    EmployeeID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create the PurchaseOrders table
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ExpectedDeliveryDate DATE,
    OrderStatus VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create the PurchaseOrderItems table
CREATE TABLE PurchaseOrderItems (
    PurchaseOrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    PurchaseOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the CycleCounts table
CREATE TABLE CycleCounts (
    CycleCountID INT PRIMARY KEY AUTO_INCREMENT,
    LocationID INT NOT NULL,
    CountDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    EmployeeID INT,
    Notes TEXT,
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create the CycleCountItems table
CREATE TABLE CycleCountItems (
    CycleCountItemID INT PRIMARY KEY AUTO_INCREMENT,
    CycleCountID INT NOT NULL,
    ProductID INT NOT NULL,
    SystemQuantity INT,
    ActualQuantity INT,
    FOREIGN KEY (CycleCountID) REFERENCES CycleCounts(CycleCountID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the Returns table
CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ReturnDate DATE NOT NULL,
    Reason VARCHAR(255),
    ReturnStatus VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create the ReturnItems table
CREATE TABLE ReturnItems (
    ReturnItemID INT PRIMARY KEY AUTO_INCREMENT,
    ReturnID INT NOT NULL,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (ReturnID) REFERENCES Returns(ReturnID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);