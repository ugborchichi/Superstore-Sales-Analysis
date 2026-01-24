DROP TABLE IF EXISTS Superstore;
CREATE TABLE Superstore
	(
	Row_ID int	PRIMARY KEY,
	Order_ID varchar (20),
	Order_Date varchar (15),
	Ship_date varchar (15),
	Ship_Mode varchar (20),
	Customer_ID	varchar (10),
	Customer_Name varchar (40),
	Segment varchar (15),
	Country varchar (15),
	City varchar (20),
	States varchar (20),
	Postal_Code int,
	Region varchar (15),
	Product_ID varchar (20),
	Category varchar (20),
	Sub_Category varchar (15),
	Product_Name varchar (140),
	Sales float,
	Quantity int,
	Discount float,
	Profit float
	);

UPDATE superstore
SET order_date = TO_DATE(order_date, 'DD/MM/YYYY'),
	ship_date = TO_DATE(ship_date, 'DD/MM/YYYY');

ALTER TABLE superstore
ALTER COLUMN order_date TYPE DATE USING order_date::DATE,
ALTER COLUMN ship_date  TYPE DATE USING ship_date::DATE;

SELECT * FROM Superstore
ORDER BY Row_id asc;

--Key Performance Indicators--

SELECT
	SUM(sales) AS total_sales,
	SUM(quantity) AS total_quantity,
	SUM(profit) AS total_profit,
	AVG(discount) AS avg_discount,
	(SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
	ROUND(AVG(ship_date - order_date), 2) AS avg_delivery_days
FROM superstore;

--What is the total sales and quantity for each segment?--

SELECT
    segment,
    SUM(sales)    AS total_sales,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;

--What is the total sales for each region?--

SELECT
	region,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Find the top 10 states by total sales--

SELECT
	states,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY states
ORDER BY total_sales DESC
LIMIT 10;

--Find the Bottom 10 states by sales--

SELECT
	states,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY states
ORDER BY total_sales ASC
LIMIT 10;

--What is the total sales by year?--

SELECT
	EXTRACT(YEAR FROM ship_date) AS year_,
	SUM(sales) 	AS total_sales
FROM superstore
GROUP BY 1
ORDER BY 2 DESC;

--What is the monthly trend by the years over sales?--

SELECT
    EXTRACT(YEAR  FROM ship_date) AS year,
    EXTRACT(MONTH FROM ship_date) AS month,
    ROUND(SUM(sales::NUMERIC), 2)  AS total_sales
FROM superstore
GROUP BY 1, 2
ORDER BY 1, 2;

--Who are the 10 top customers by sales--

SELECT
	customer_name,
	SUM(sales)	AS total_sales
FROM superstore
GROUP BY 1
ORDER BY total_sales DESC
LIMIT 10;

--Who are the 10 Bottom customers by sales--

SELECT
	customer_name,
	SUM(sales)	AS total_sales
FROM superstore
GROUP BY 1
ORDER BY total_sales ASC
LIMIT 10;

--What is the avg shipping period for the ship mode--

SELECT
	ship_mode,
	ROUND(AVG(ship_date - order_date), 2) AS avg_delivery_days
FROM Superstore
GROUP BY 1;

--What is the total profit by category?--

SELECT
	category,
	SUM(profit) AS total_profit
FROM superstore
GROUP BY 1
ORDER BY 1 DESC;

--What are the top 10 products by quantity?--

SELECT 
	product_name,
	SUM(quantity) AS total_quantity
FROM superstore
GROUP BY 1
ORDER BY total_quantity DESC
LIMIT 10;

--What are the Bottom 10 products by quantity?--

SELECT 
	product_name,
	category,
	SUM(quantity) AS total_quantity
FROM superstore
GROUP BY 1,2
ORDER BY 3 ASC
LIMIT 10;

--Avg shipping period by Region--

SELECT
	region,
	ROUND(AVG(ship_date - order_date), 2) AS avg_delivery_days
FROM superstore
GROUP BY region
ORDER BY avg_delivery_days ASC;

--What is the average discount given by category?--

SELECT
	category,
	AVG(discount) AS avg_discount
FROM superstore
GROUP BY 1
ORDER BY 1 DESC;

--End of Analysis--



