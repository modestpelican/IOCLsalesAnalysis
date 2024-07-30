-- Create database
CREATE DATABASE IF NOT EXISTS indianOilSales;

-- Use the created database
USE indianOilSales;

-- Create table
CREATE TABLE IF NOT EXISTS transactions (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    station VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    fuel_type VARCHAR(100) NOT NULL,  -- Changed from product_line to fuel_type
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);

-- Data cleaning
SELECT * FROM transactions;

-- Add the time_of_day column
ALTER TABLE transactions ADD COLUMN time_of_day VARCHAR(20);

UPDATE transactions
SET time_of_day = (
    CASE
        WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

-- Add day_name column
ALTER TABLE transactions ADD COLUMN day_name VARCHAR(10);

UPDATE transactions
SET day_name = DAYNAME(date);

-- Add month_name column
ALTER TABLE transactions ADD COLUMN month_name VARCHAR(10);

UPDATE transactions
SET month_name = MONTHNAME(date);

-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT DISTINCT city FROM transactions;

-- In which city is each station?
SELECT DISTINCT city, station FROM transactions;

-- --------------------------------------------------------------------
-- ---------------------------- Fuel -------------------------------
-- --------------------------------------------------------------------

-- How many unique fuel types does the data have?
SELECT DISTINCT fuel_type FROM transactions;

-- What is the most sold fuel type?
SELECT
    SUM(quantity) as qty,
    fuel_type
FROM transactions
GROUP BY fuel_type
ORDER BY qty DESC;

-- What is the total revenue by month?
SELECT
    month_name AS month,
    SUM(total) AS total_revenue
FROM transactions
GROUP BY month_name
ORDER BY total_revenue;

-- What month had the largest COGS?
SELECT
    month_name AS month,
    SUM(cogs) AS cogs
FROM transactions
GROUP BY month_name
ORDER BY cogs DESC;

-- What fuel type had the largest revenue?
SELECT
    fuel_type,
    SUM(total) as total_revenue
FROM transactions
GROUP BY fuel_type
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
    station,
    city,
    SUM(total) AS total_revenue
FROM transactions
GROUP BY city, station
ORDER BY total_revenue DESC;

-- What fuel type had the largest VAT?
SELECT
    fuel_type,
    AVG(tax_pct) as avg_tax
FROM transactions
GROUP BY fuel_type
ORDER BY avg_tax DESC;

-- Fetch each fuel type and add a column to those fuel 
-- type showing "Good", "Bad". Good if its greater than average sales
SELECT
    fuel_type,
    CASE
        WHEN AVG(quantity) > (SELECT AVG(quantity) FROM transactions) THEN "Good"
        ELSE "Bad"
    END AS remark
FROM transactions
GROUP BY fuel_type;

-- Which station sold more fuel than the average quantity sold?
SELECT
    station,
    SUM(quantity) AS qty
FROM transactions
GROUP BY station
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM transactions);

-- What is the most common fuel type by gender?
SELECT
    gender,
    fuel_type,
    COUNT(gender) AS total_cnt
FROM transactions
GROUP BY gender, fuel_type
ORDER BY total_cnt DESC;

-- What is the average rating of each fuel type?
SELECT
    ROUND(AVG(rating), 2) as avg_rating,
    fuel_type
FROM transactions
GROUP BY fuel_type
ORDER BY avg_rating DESC;

-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM transactions;

-- How many unique payment methods does the data have?
SELECT DISTINCT payment FROM transactions;

-- What is the most common customer type?
SELECT
    customer_type,
    COUNT(*) as count
FROM transactions
GROUP BY customer_type
ORDER BY count DESC;

-- Which customer type buys the most?
SELECT
    customer_type,
    COUNT(*)
FROM transactions
GROUP BY customer_type;

-- What is the gender of most of the customers?
SELECT
    gender,
    COUNT(*) as gender_cnt
FROM transactions
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per station?
SELECT
    gender,
    COUNT(*) as gender_cnt
FROM transactions
WHERE station = "A"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- Which time of the day do customers give most ratings?
SELECT
    time_of_day,
    AVG(rating) AS avg_rating
FROM transactions
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per station?
SELECT
    time_of_day,
    AVG(rating) AS avg_rating
FROM transactions
WHERE station = "A"
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?
SELECT
    day_name,
    AVG(rating) AS avg_rating
FROM transactions
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per station?
SELECT
    day_name,
    COUNT(day_name) AS total_sales
FROM transactions
WHERE station = "A"
GROUP BY day_name
ORDER BY total_sales DESC;

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday
SELECT
    time_of_day,
    COUNT(*) AS total_sales
FROM transactions
WHERE day_name = "Sunday"
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- Which of the customer types brings the most revenue?
SELECT
    customer_type,
    SUM(total) AS total_revenue
FROM transactions
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest tax/VAT percent?
SELECT
    city,
    ROUND(AVG(tax_pct), 2) AS avg_tax_pct
FROM transactions
GROUP BY city
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
    customer_type,
    AVG(tax_pct) AS total_tax
FROM transactions
GROUP BY customer_type
ORDER BY total_tax DESC;
