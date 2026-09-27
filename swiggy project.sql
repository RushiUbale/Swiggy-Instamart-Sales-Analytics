CREATE DATABASE SwiggyInstamartDB;
USE SwiggyInstamartDB;
SHOW DATABASES;

CREATE TABLE instamart_sales (
    Order_ID BIGINT PRIMARY KEY,
    Order_Date DATE,
    Customer_ID INT,
    City VARCHAR(50),
    Area VARCHAR(80),
    Store_ID VARCHAR(30),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(100),
    Category VARCHAR(60),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Percent DECIMAL(5,2),
    Discount_Amount DECIMAL(10,2),
    Delivery_Fee DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    Cost DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Payment_Method VARCHAR(30),
    Order_Status VARCHAR(30),
    Delivery_Time_Min INT,
    Customer_Rating DECIMAL(2,1)
);

SHOW TABLES;
DESC instamart_sales;

SELECT COUNT(*) AS total_rows
FROM instamart_sales;

USE SwiggyInstamartDB;

USE SwiggyInstamartDB;

SET GLOBAL local_infile = 1;

TRUNCATE TABLE instamart_sales;

LOAD DATA LOCAL INFILE 'C:/Users/ASUS/Desktop/swiggy_instamart_sales_50k_clean.csv'
INTO TABLE instamart_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Order_ID,
    Order_Date,
    Customer_ID,
    City,
    Area,
    Store_ID,
    Product_ID,
    Product_Name,
    Category,
    Quantity,
    Unit_Price,
    Discount_Percent,
    Discount_Amount,
    Delivery_Fee,
    Revenue,
    Cost,
    Profit,
    Payment_Method,
    Order_Status,
    Delivery_Time_Min,
    Customer_Rating
);

SHOW VARIABLES LIKE 'secure_file_priv';


USE SwiggyInstamartDB;

SELECT COUNT(*) AS Total_Rows
FROM instamart_sales;

SELECT *
FROM instamart_sales
LIMIT 10;

SELECT
    MIN(Order_Date) AS First_Order,
    MAX(Order_Date) AS Last_Order,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM instamart_sales;

USE SwiggyInstamartDB;

	SELECT
		COUNT(DISTINCT Order_ID) AS Total_Orders,
		COUNT(DISTINCT Customer_ID) AS Total_Customers,
		SUM(Quantity) AS Total_Quantity,
		ROUND(SUM(Revenue), 2) AS Total_Revenue,
		ROUND(SUM(Cost), 2) AS Total_Cost,
		ROUND(SUM(Profit), 2) AS Total_Profit,
		ROUND(AVG(Customer_Rating), 2) AS Avg_Customer_Rating
	FROM instamart_sales
	WHERE Order_Status = 'Delivered';
    
    SELECT
    Order_Status,
    COUNT(*) AS Total_Orders,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM instamart_sales),
        2
    ) AS Order_Percentage
FROM instamart_sales
GROUP BY Order_Status
ORDER BY Total_Orders DESC;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;

SELECT
    City,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(AVG(Customer_Rating), 2) AS Avg_Rating
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY City
ORDER BY Revenue DESC;

SELECT
    Category,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit,
    ROUND(AVG(Customer_Rating), 2) AS Avg_Rating
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY Revenue DESC;

SELECT
    Product_ID,
    Product_Name,
    Category,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY
    Product_ID,
    Product_Name,
    Category
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY Payment_Method
ORDER BY Revenue DESC;

SELECT
    Order_Status,
    ROUND(AVG(Delivery_Time_Min), 2) AS Avg_Delivery_Time,
    ROUND(MIN(Delivery_Time_Min), 2) AS Min_Delivery_Time,
    ROUND(MAX(Delivery_Time_Min), 2) AS Max_Delivery_Time
FROM instamart_sales
WHERE Delivery_Time_Min IS NOT NULL
GROUP BY Order_Status
ORDER BY Avg_Delivery_Time;

SELECT
    Product_ID,
    Product_Name,
    Category,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY
    Product_ID,
    Product_Name,
    Category
ORDER BY Revenue DESC
LIMIT 10;

SELECT
    City,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Quantity) AS Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Cost), 2) AS Cost,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY City
ORDER BY Revenue DESC;

SELECT
    Category,
    SUM(Quantity) AS Quantity_Sold,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Revenue,
    ROUND(SUM(Cost), 2) AS Cost,
    ROUND(SUM(Profit), 2) AS Profit
FROM instamart_sales
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY Revenue DESC;