# Superstore Sales Analysis

## Project Overview

This project was carried out to demostrate SQL skills and techniques typically used as a Data Analyst to explore and analyse superstore sales dataset from 2011 till 2015. The project involves setting up a superstore database, creating a table and answering specific business questions through SQL queries. 

## Objectives

1.  Data cleaning: Excel was used to clean the dataset set before exporting to SQL.
2.  Set up a Sperstore database: Create and populate the superstore database with the provided sales data.
3.  Exploratory Data Analysis: Perform basis exploratory data analysis to understand the dataset.
4.  Busisness Analysis: Use   SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1.  Database and Table creation

   -  The project starts by creating a database called ```superstore_db```
   -  Table creation: The table named ```superstore``` is created to store the sales data. The table structure includes columns for row id, order id, order date, ship date, ship mode, customer id, customer name, segment, country, city, state, postal code, region, product id, category, sub-caregory, product name, sales quantity, discount and profit.
``` sql
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
 ```

### 2.  Data Exploration

   -  Determine the total number of recored in a dateset.
   -  Identify all unique product category and sub category.
   -  Check for any null value in the dataset and delete where necessary.

  ```sql
SELECT * FROM Superstore
ORDER BY Row_id asc;

SELECT DISTINCT category FROM superstore;

SELECT DISTINCT sub_category FROM superstore;

SELECT * FROM superstore
	WHERE 
	Row_ID IS null or
	Order_ID is null or
	Order_Date is null or
	Ship_date is null or
	Ship_Mode is null or
	Customer_ID	is null or
	Customer_Name is null or
	Segment is null or
	Country is null or
	City is null or
	States is null or
	Postal_Code is null or
	Region is null or
	Product_ID is null or
	Category is null or
	Sub_Category is null or
	Product_Name is null or
	Sales is null or
	Quantity is null or
	Discount is null or
	Profit is null;
```
### 3.  Data Analysis and Findings

The following SQL queries were developed to answer some key business questions.

1.  **What are the 5 key performance indicators
```sql
SELECT
	SUM(sales) AS total_sales,
	SUM(quantity) AS total_quantity,
	SUM(profit) AS total_profit,
	AVG(discount) AS avg_discount,
	(SUM(profit) / SUM(sales)) * 100 AS profit_margin_pct,
	ROUND(AVG(ship_date - order_date), 2) AS avg_delivery_days
FROM superstore;
```

2.  **What is the total sales and quantity for each segment?
```sql
SELECT
    segment,
    SUM(sales)    AS total_sales,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY segment
ORDER BY total_sales DESC;
```

3.  **What is the total sales for each region?
```sql
SELECT
	region,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
```

4.  **what is the total sales and quantity for 2014 from January to December?
```sql
SELECT
	EXTRACT(YEAR  FROM ship_date) AS year,
    EXTRACT(MONTH FROM ship_date) AS month,
	SUM(sales) AS total_sales,
	SUM(quantity) AS total_quantity
FROM superstore
WHERE EXTRACT(YEAR FROM ship_date) = 2014
GROUP BY 1, 2
ORDER BY 2;
```

5.  **Find the top 10 states by total sales
```sql
SELECT
	states,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY states
ORDER BY total_sales DESC
LIMIT 10;
```

6.  **Find the Bottom 10 states by sales
```sql
SELECT
	states,
	SUM(sales)	AS total_sales 
FROM superstore
GROUP BY states
ORDER BY total_sales ASC
LIMIT 10;
```

7. **What is the Avg shipping period by Region?
```sql
SELECT
	region,
	ROUND(AVG(ship_date - order_date), 2) AS avg_delivery_days
FROM superstore
GROUP BY region
ORDER BY avg_delivery_days ASC;
```

8.  **What is the avg delivery days by ship mode?
```sql
SELECT
	ship_mode,
	AVG(ship_date - order_date) AS avg_delivery_days
FROM superstore
GROUP BY 1
ORDER BY 2;
```
9.  **What products have not sold more than 3 units?
```sql
SELECT
    product_name,
    SUM(quantity) AS total_quantity
FROM superstore
GROUP BY product_name
HAVING SUM(quantity) < 3
ORDER BY total_quantity DESC;
```

## Key Insights

-  Sales growth was modest between 2011 and 2012, followed by a strong acceleration in 2013 from 2% to 26% growth rate and sustained high growth into 2014, indicating successful expansion and increased demand in later years.
-  Technology contributes 51% of total profit, while Furniture contributes just 6%.
-  The sales trend shows an spike in sales in month of september, november and December.
-  Some product recorded less than 5 units sold in a period of 4 years.

## Recommendations

-  Allocate more resources to Technology products, including inventory availability, marketing spend, and promotional visibility.
-  Protect profit margins in Technology by limiting excessive discounting and optimizing pricing strategies.
-  Plan targeted seasonal marketing campaigns around these peak months to maximize revenue.
-  Introduce bundled offers and cross-selling strategies during peak months to increase average order value.
-  Identify low-performing products and evaluate whether they should be discontinued, repositioned, or discounted.
-  Reallocate shelf space and marketing focus to high-demand and high-margin products.

## Conclusion

The Superstore analysis shows strong sales growth from 2013 onward, indicating successful expansion and rising demand. Technology is the primary profit driver, while Furniture underperforms, highlighting the need for better product and pricing strategies. Seasonal sales peaks in the last quarter present opportunities for targeted planning, and low-performing products indicate areas for portfolio optimization. Overall, focusing on high-margin categories and data-driven planning will support sustainable and profitable growth.
