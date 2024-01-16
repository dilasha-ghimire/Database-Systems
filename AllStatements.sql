-- Connecting to local host and creating database
\sql
\connect root@localhost:3306
CREATE DATABASE OM_Luxury;
show databases;
use OM_Luxury;

-- Creating normalized tables
CREATE TABLE Item_Description (
    ItemCode INT(10) AUTO_INCREMENT PRIMARY KEY,
    Item_Name_Dilasha VARCHAR(255),
    Price_per_unit INT(10)
);
CREATE TABLE Salesperson_Details (
    SalespersonCode INT PRIMARY KEY AUTO_INCREMENT,
    Salesperson_name VARCHAR(255)
);
CREATE TABLE Customer_Details (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(255),
    Last_Name VARCHAR(255),
    Email VARCHAR(255),
    Phone_Number INT
);
CREATE TABLE Sales_Details (
    Date DATE,
    Time TIME,
    ItemCode INT,
    Quantity INT,
    Total_Sales INT,
    SalespersonCode INT,
    CustomerID INT,
    FOREIGN KEY (ItemCode) REFERENCES Item_Description(ItemCode),
    FOREIGN KEY (SalespersonCode) REFERENCES Salesperson_Details(SalespersonCode),
    FOREIGN KEY (CustomerID) REFERENCES Customer_Details(CustomerID)
);
CREATE TABLE City_Details (
    City VARCHAR(255) PRIMARY KEY,
    Postal_Code INT
);
CREATE TABLE Customer_Address (
    CustomerID INT,
    Address_Dilasha VARCHAR(255),
    City VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer_Details(CustomerID),
    FOREIGN KEY (City) REFERENCES City_Details(City)
);
CREATE TABLE Membership_Tiers_and_Perks (
    Tier VARCHAR(255) PRIMARY KEY,
    Perk VARCHAR(10000)
);
CREATE TABLE Customer_Membership (
    CustomerID INT,
    Customer_Name_Dilasha VARCHAR(255),
    Tier VARCHAR(255),
    FOREIGN KEY (CustomerID) REFERENCES Customer_Details(CustomerID),
    FOREIGN KEY (Tier) REFERENCES Membership_Tiers_and_Perks(Tier)
);
CREATE TABLE Delivery_Information (
    CustomerID INT,
    Delivery_Address_Dilasha VARCHAR(255),
    Delivery_Date DATE,
    Delivery_Time TIME,
    FOREIGN KEY (CustomerID) REFERENCES Customer_Details(CustomerID)
);
CREATE TABLE Suppliers (
    SupplierID VARCHAR(255) PRIMARY KEY,
    Supplier_Address VARCHAR(10000),
    Contact_Number INT
);
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    Category_Name VARCHAR(255)
);
CREATE TABLE Brands (
    Brand_ID INT PRIMARY KEY,
    Brand_Name VARCHAR(255)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product_Name_Dilasha VARCHAR(255),
    Description VARCHAR(10000),
    Price INT,
    SupplierID VARCHAR(255),
    CategoryID INT,
    Brand_ID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (Brand_ID) REFERENCES Brands(Brand_ID)
);
CREATE TABLE Purchase_Orders (
    PO_Number INT PRIMARY KEY,
    SupplierID VARCHAR(255),
    ProductID INT,
    Quantity INT,
    Cost_Price INT,
    Order_Date DATE,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Data Insertion
INSERT INTO Item_Description (Item_Name_Dilasha, Price_per_unit)
VALUES
    ('Sari', 15000),
    ('Kurta', 4000),
    ('Lehenga Choli', 20000),
    ('Sherwani', 4500),
    ('Anarkali', 12000),
    ('Salwar Kameez', 4000),
    ('Ghagra Choli', 21000),
    ('Dupatta', 6000),
    ('Indo-Western Gown', 7000);
INSERT INTO Salesperson_Details (Salesperson_name)
VALUES
    ('Aashma Regmi'),
    ('Ambika Lamichhane'),
    ('Pooja Manandhar'),
    ('Sarah Ghimire'),
    ('Subhadra Thapa');
INSERT INTO Customer_Details (First_Name, Last_Name, Email, Phone_Number)
VALUES
    ('Ram', 'Sharma', 'ram.sharma@gmail.com', 9841234567),
    ('Sita', 'Shrestha', 'sita.shrestha@gmail.com', 9809876543),
    ('Hari', 'Maharjan', 'hari.maharjan@gmail.com', 9867543210),
    ('Gita', 'Joshi', 'gita.joshi@gmail.com', 9845678901),
    ('Raju', 'Thapa', 'raju.thapa@gmail.com', 9812345678),
    ('Ram', 'Gurung', NULL, NULL),
    ('Sita', 'Tamang', NULL, NULL),
    ('Hari', 'Sharma', NULL, NULL),
    ('Raju', 'Karki', NULL, NULL),
    ('Amit', 'Khanal', NULL, 9812345678),
    ('Rita', 'Dhakal', NULL, 9841234567),
    ('Simran', 'KC', NULL, 9809876543);
INSERT INTO Sales_Details (Date, Time, ItemCode, Quantity, Total_Sales, SalespersonCode, CustomerID)
VALUES
    ('2022-03-21', '18:15:37', 1, 10, 150000, 2, 5),
    ('2022-03-22', '14:15:16', 2, 5, 20000, 1, 10),
    ('2022-03-23', '12:47:34', 3, 8, 160000, 4, 12),
    ('2022-03-24', '15:56:08', 4, 3, 13500, 2, 6),
    ('2022-03-25', '10:05:45', 5, 6, 72000, 5, 1),
    ('2022-03-26', '17:53:34', 6, 4, 16000, 4, 7),
    ('2022-03-27', '18:44:48', 7, 7, 147000, 5, 3),
    ('2022-03-28', '16:56:42', 8, 12, 72000, 3, 4),
    ('2022-03-29', '18:03:57', 9, 2, 14000, 5, 9);
INSERT INTO City_Details (City, Postal_Code)
VALUES
    ('Lalitpur', 44700),
    ('Kathmandu', 44600);
INSERT INTO Customer_Address (CustomerID, Address_Dilasha, City)
VALUES
    (1, 'Tinkune', 'Kathmandu'),
    (2, 'Pulchowk', 'Lalitpur'),
    (3, 'Gaushala', 'Kathmandu'),
    (4, 'Chabahil', 'Kathmandu'),
    (5, 'Thamel', 'Kathmandu');
INSERT INTO Membership_Tiers_and_Perks (Tier, Perk)
VALUES
    ('Platinum', 'Free shipping, 15% off all purchases, first access to new products, exclusive discounts, gift wrapping, personal shopping service, exclusive invitation to events'),
    ('Gold', '10% off all purchases, access to new products after Platinum'),
    ('Silver', '5% off all purchases'),
    ('Non-member', 'No benefits');
INSERT INTO Customer_Membership (CustomerID, Customer_Name_Dilasha, Tier)
SELECT CustomerID, CONCAT(First_Name, ' ', Last_Name), 'Platinum'
FROM Customer_Details
WHERE First_Name = 'Ram' AND Last_Name = 'Gurung';
INSERT INTO Customer_Membership (CustomerID, Customer_Name_Dilasha, Tier)
SELECT CustomerID, CONCAT(First_Name, ' ', Last_Name), 'Gold'
FROM Customer_Details
WHERE First_Name = 'Sita' AND Last_Name = 'Tamang';
INSERT INTO Customer_Membership (CustomerID, Customer_Name_Dilasha, Tier)
SELECT CustomerID, CONCAT(First_Name, ' ', Last_Name), 'Silver'
FROM Customer_Details
WHERE First_Name = 'Hari' AND Last_Name = 'Sharma';
INSERT INTO Customer_Membership (CustomerID, Customer_Name_Dilasha, Tier)
SELECT CustomerID, CONCAT(First_Name, ' ', Last_Name), 'Non-Member'
FROM Customer_Details
WHERE First_Name = 'Raju' AND Last_Name = 'Karki';
INSERT INTO Delivery_Information (CustomerID, Delivery_Address_Dilasha, Delivery_Date, Delivery_Time)
VALUES
    (10, 'Butwal-11', '2023-03-24', '10:00:00'),
    (11, 'Butwal-12', '2023-03-25', '14:00:00'),
    (12, 'Butwal-13', '2023-02-26', '16:00:00');
INSERT INTO Suppliers (SupplierID, Supplier_Address, Contact_Number)
VALUES
    ('S001', 'Kathmandu', 9860123456),
    ('S002', 'Lalitpur', 9841234567),
    ('S003', 'Bhaktapur', 9812345678);
INSERT INTO Category (CategoryID, Category_Name)
VALUES
    (001, 'topi'),
    (002, 'clothing');
INSERT INTO Brands (Brand_ID, Brand_Name)
VALUES
    (001, 'ABC'),
    (002, 'PQR'),
    (003, 'XYZ');
INSERT INTO Products (ProductID, Product_Name_Dilasha, Description, Price, SupplierID, CategoryID, Brand_ID)
VALUES
    (1, 'Dhaka Saree', 'A handloom saree made in Dhaka, Bangladesh', 5000, 'S001', NULL, NULL),
    (2, 'Dhaka Panjabi', 'A handloom panjabi made in Dhaka, Bangladesh', 2500, 'S001', NULL, NULL),
    (3, 'Kurta Suruwal', 'A traditional Nepali dress for men', 3000, 'S002', NULL, NULL),
    (4, 'Dhaka Silk Saree', 'A handloom silk saree made in Dhaka, Bangladesh', 8000, 'S001', NULL, NULL),
    (5, 'Dhaka Silk Panjabi', 'A handloom silk panjabi made in Dhaka, Bangladesh', 4500, 'S001', NULL, NULL),
    (6, 'Sherwani', 'A traditional Indian dress for men', 10000, 'S003', NULL, NULL);
INSERT INTO Purchase_Orders (PO_Number, SupplierID, ProductID, Quantity, Cost_Price, Order_Date)
VALUES
    (1, 'S001', 1, 10, 100, '2023-03-01'),
    (2, 'S002', 2, 5, 500, '2023-03-15'),
    (3, 'S003', 3, 8, 1000, '2023-03-20');

-- Data Manipulation

-- Question 3
INSERT INTO Purchase_Orders (PO_Number, SupplierID, ProductID, Quantity, Cost_Price, Order_Date)
VALUES
    (4, 'S001', 4, 20, 200, '2023-07-29'),
    (5, 'S002', 5, 15, 1500, '2023-08-01'),
    (6, 'S003', 6, 12, 1200, '2023-08-02'),
    (7, 'S001', 3, 6, 600, '2023-08-05'),
    (8, 'S002', 4, 3, 300, '2023-08-07');
SELECT *
FROM Purchase_Orders
WHERE Order_Date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 WEEK);

-- Question 4
INSERT INTO Sales_Details (Date, Time, ItemCode, Quantity, Total_Sales, SalespersonCode, CustomerID)
VALUES
    ('2023-07-15', '10:30:45', 1, 5, 75000, 3, 8),
    ('2023-07-18', '14:20:12', 2, 3, 12000, 4, 11),
    ('2023-07-22', '16:45:22', 3, 6, 48000, 1, 2),
    ('2023-07-25', '11:55:30', 4, 2, 9000, 5, 7),
    ('2023-07-29', '15:10:18', 5, 7, 63000, 2, 6),
    ('2023-08-03', '09:30:50', 1, 4, 60000, 5, 1);
SELECT SUM(Quantity) AS TotalQuantitySold
FROM Sales_Details
JOIN Item_Description ON Sales_Details.ItemCode = Item_Description.ItemCode
WHERE Item_Description.Item_Name_Dilasha = 'Sari'
  AND Sales_Details.Date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);

-- Question 5
SELECT COUNT(*) AS SalesMadeByPoojaManandhar
FROM Sales_Details
JOIN Salesperson_Details ON Sales_Details.SalespersonCode = Salesperson_Details.SalespersonCode
WHERE Salesperson_Details.Salesperson_name = 'Pooja Manandhar';

-- Question 6
SELECT Customer_Details.First_Name, Customer_Details.Last_Name
FROM Sales_Details
JOIN Customer_Details ON Sales_Details.CustomerID = Customer_Details.CustomerID
WHERE Sales_Details.Total_Sales > 50000;

-- Question 7
SELECT COUNT(Sales_Details.CustomerID) AS TotalCustomers
FROM Sales_Details
WHERE TIME(Sales_Details.Time) BETWEEN '18:00:00' AND '19:00:00';

-- Question 8
INSERT INTO Item_Description (Item_Name_Dilasha, Price_per_unit)
VALUES
    ('Kurti', 3000),
    ('Jeans', 2500),
    ('T-shirt', 800),
    ('Blouse', 1000),
    ('Jacket', 5000);
INSERT INTO Sales_Details (Date, Time, ItemCode, Quantity, Total_Sales, SalespersonCode, CustomerID)
VALUES
    ('2023-08-10', '17:30:00', 10, 4, 12000, 3, 8),
    ('2023-08-11', '14:45:00', 11, 2, 5000, 2, 5),
    ('2023-08-12', '18:00:00', 12, 3, 3000, 4, 9);
SELECT Item_Description.Item_Name_Dilasha, SUM(Sales_Details.Total_Sales) AS TotalRevenueGenerated
FROM Sales_Details
JOIN Item_Description ON Sales_Details.ItemCode = Item_Description.ItemCode
WHERE Sales_Details.Date >= '2022-02-18' AND Sales_Details.Date <= '2023-08-16'
GROUP BY Item_Description.Item_Name_Dilasha
ORDER BY TotalRevenueGenerated DESC
LIMIT 10;

-- Question 9
SELECT DAYNAME(Date) AS DayOfWeek, AVG(Total_Sales) AS AverageTransactionValue
FROM Sales_Details
GROUP BY DayOfWeek;

-- Question 10
DELETE FROM Sales_Details
WHERE Date < DATE_SUB(NOW(), INTERVAL 1 YEAR);
