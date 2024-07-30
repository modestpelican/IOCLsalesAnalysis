# IndianOil Sales Data Analysis

## About

This project aims to explore the IndianOil sales data to gain insights into top-performing stations, fuel types, and customer behavior. The goal is to analyze sales trends, understand customer preferences, and optimize sales strategies. The dataset used for this analysis includes sales transactions from IndianOil's various stations.

## Purpose of the Project

The primary objective of this project is to analyze sales data from IndianOil to identify factors affecting sales at different stations. This includes:

- Evaluating the performance of different fuel types.
- Understanding sales trends over time.
- Analyzing customer behavior and preferences.
- Identifying opportunities for improving sales strategies.

## About the Data

The dataset contains sales transactions from IndianOil stations, including the following columns:

| Column             | Description                                   | Data Type       |
|--------------------|-----------------------------------------------|-----------------|
| invoice_id         | Unique identifier for each sale               | VARCHAR(30)     |
| station            | Station at which sales were made              | VARCHAR(5)      |
| city               | City where the station is located             | VARCHAR(30)     |
| customer_type      | Type of the customer (e.g., Regular, Member)  | VARCHAR(30)     |
| gender             | Gender of the customer                        | VARCHAR(10)     |
| fuel_type          | Type of fuel sold                             | VARCHAR(100)    |
| unit_price         | Price per unit of the fuel (INR)              | DECIMAL(10,2)   |
| quantity           | Quantity of fuel sold                         | INT             |
| tax_pct            | Tax percentage applied                        | FLOAT(6,4)      |
| total              | Total cost of the sale (INR)                  | DECIMAL(12,4)   |
| date               | Date of the transaction                       | DATE            |
| time               | Time of the transaction                       | TIMESTAMP       |
| payment            | Payment method used                           | VARCHAR(15)     |
| cogs               | Cost of Goods Sold (INR)                      | DECIMAL(10,2)   |
| gross_margin_pct   | Gross margin percentage                       | FLOAT(11,9)     |
| gross_income       | Gross income from the sale (INR)              | DECIMAL(12,4)   |
| rating             | Customer rating                               | FLOAT(2,1)      |

## Analysis List

### Product Analysis

- Evaluate different fuel types and their performance.
- Identify the most and least popular fuel types.
- Analyze revenue generated from each fuel type.

### Sales Analysis

- Analyze sales trends over different times of the day and months.
- Evaluate the effectiveness of sales strategies.
- Determine the impact of seasonal factors and promotions.

### Customer Analysis

- Identify different customer segments and their purchase behavior.
- Analyze the impact of customer types on sales and revenue.
- Evaluate gender distribution and preferences.

## Approach Used

1. **Data Wrangling**: Inspect the data to detect and handle missing or NULL values. Prepare the dataset for analysis.
   
2. **Build a Database**: Create the necessary database and tables. Insert the data and ensure no NULL values exist in critical fields.

3. **Feature Engineering**: 
   - Add columns such as `time_of_day`, `day_name`, and `month_name` to enhance insights into sales patterns.

4. **Exploratory Data Analysis (EDA)**: Perform EDA to answer key business questions and gain insights from the data.

## Business Questions to Answer

### Generic Questions

- How many unique cities are represented in the data?
- In which city is each station located?

### Product Analysis

- How many unique fuel types are in the dataset?
- What is the most common payment method?
- Which fuel type generates the highest revenue?
- What is the total revenue by month?
- What month had the highest COGS?
- Which fuel type had the largest revenue?
- Which city has the highest revenue?
- Fetch each fuel type and categorize them as "Good" or "Bad" based on sales performance.

### Sales Analysis

- Number of sales made in each time of the day and by day of the week.
- Which customer type generates the most revenue?
- Which city has the highest tax percentage/VAT?
- Which customer type pays the most in VAT?

### Customer Analysis

- How many unique customer types are there?
- What is the most common customer type?
- Which customer type makes the most purchases?
- What is the gender distribution across stations?
- What time of the day receives the most ratings?

## Revenue and Profit Calculations

- **COGS** = Unit Price * Quantity (INR)
- **VAT** = 5% * COGS
- **Total (Gross Sales)** = VAT + COGS
- **Gross Income** = Total (Gross Sales) - COGS
- **Gross Margin Percentage** = (Gross Income / Total Revenue) * 100

**Example Calculation:**

For a sale with:
- Unit Price: ₹45.79
- Quantity: 7

**COGS** = 45.79 * 7 = ₹320.53

**VAT** = 5% * COGS = 0.05 * 320.53 = ₹16.03

**Total (Gross Sales)** = VAT + COGS = 16.03 + 320.53 = ₹336.56

**Gross Margin Percentage** = (Gross Income / Total Revenue) = (16.03 / 336.56) * 100 ≈ 4.76%

## Code

For SQL scripts and queries, refer to the `SQL_queries.sql` file included in this repository.

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS indianOilSales;

-- Create table
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    station VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    fuel_type VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4),
    rating FLOAT(2,1)
);
