

-- Create a table

CREATE TABLE products
(Product_ID INT NOT NULL PRIMARY KEY,
Product_Name VARCHAR,
Product_Category VARCHAR,
Product_Cost NUMERIC,
Product_Price NUMERIC);

CREATE TABLE stores
(Store_ID INT NOT NULL PRIMARY KEY,
Store_Name VARCHAR,
Store_City VARCHAR,
Store_Location VARCHAR,
Store_Open_Date DATE
);

CREATE TABLE inventory
(Store_ID INT REFERENCES stores (Store_ID),
Product_ID INT REFERENCES products (Product_ID),
Stock_On_Hand NUMERIC
);


CREATE TABLE sales
(Sale_ID INT NOT NULL PRIMARY KEY,
Date DATE,
Store_ID INT REFERENCES stores (Store_ID),
Product_ID INT REFERENCES products (Product_ID),
Units NUMERIC
);


-- insert csv files for importing

COPY products
FROM 'D:\Onedrive Folder\OneDrive - Alpha Riot\Projects\Portfolio\Mexico Toy Store\Maven+Toys+Data\products.csv'
WITH (FORMAT csv, HEADER)

COPY stores
FROM 'D:\Onedrive Folder\OneDrive - Alpha Riot\Projects\Portfolio\Mexico Toy Store\Maven+Toys+Data\stores.csv'
WITH (FORMAT csv, HEADER)

COPY inventory
FROM 'D:\Onedrive Folder\OneDrive - Alpha Riot\Projects\Portfolio\Mexico Toy Store\Maven+Toys+Data\inventory.csv'
WITH (FORMAT csv, HEADER)

COPY sales
FROM 'D:\Onedrive Folder\OneDrive - Alpha Riot\Projects\Portfolio\Mexico Toy Store\Maven+Toys+Data\sales.csv'
WITH (FORMAT csv, HEADER)

SELECT *
FROM sales

-- See if you can analyze the ff:

-- Find the date with the highest recorded profit

SELECT 
	date, 
	SUM(units * products.product_price) AS total_profit
FROM sales
JOIN products
ON sales.product_id = products.product_id
GROUP BY date
ORDER BY total_profit DESC
LIMIT 1;

-- 2018-04-30 recorded the date with the highest profit from sales



-- Find the date with the highest recorded sales
SELECT 
	date, 
	SUM(units) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
GROUP BY date, units
ORDER BY total_sales DESC
LIMIT 1;

--2018-04-30 was the date with the highest recorded total sales recorded



-- Find the top 5 store with the highest recorded overall sales
SELECT 
	store_name, 
	SUM(units) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
JOIN stores
ON sales.store_id = stores.store_id
GROUP BY store_name
ORDER BY total_sales DESC
LIMIT 5;

-- Find the top 5 store with the least recorded overall sales

SELECT 
	store_name, 
	SUM(units) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
JOIN stores
ON sales.store_id = stores.store_id
GROUP BY store_name
ORDER BY total_sales ASC
LIMIT 5;


-- Find the overall best selling toy by sales
SELECT 
	product_name, 
	SUM(units) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

--Colorbuds is the highest overall selling toy.



-- Find the overall least selling toy by sales
SELECT 
	product_name, 
	SUM(units) AS total_sales
FROM sales
JOIN products
ON sales.product_id = products.product_id
GROUP BY product_name
ORDER BY total_sales ASC
LIMIT 5;

--Mini Basketball Hoop is the product with least sales

-- What store location is the most profitable
SELECT 
	store_name, 
	SUM(units * products.product_price) AS total_profit
FROM sales
JOIN products
ON sales.product_id = products.product_id
JOIN stores
ON sales.store_id = stores.store_id
GROUP BY store_name
ORDER BY total_profit DESC
LIMIT 5;
--Maven Toys Ciudad de Mexico 2 recorded the overall highest total profit

-- What store location is the least profitable
SELECT 
	store_name, 
	SUM(units * products.product_price) AS total_profit
FROM sales
JOIN products
ON sales.product_id = products.product_id
JOIN stores
ON sales.store_id = stores.store_id
GROUP BY store_name
ORDER BY total_profit ASC
LIMIT 5;
-- Maven Toys Campeche 2 recorded the least overall profit.
