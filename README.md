# IndianOil Sales Analysis

This repository contains SQL scripts for analyzing sales data from IndianOil. The scripts cover various aspects of sales analysis, including revenue by fuel type, customer demographics, and performance metrics.

## Table of Contents

- [Database and Table Creation](#database-and-table-creation)
- [Data Cleaning and Preparation](#data-cleaning-and-preparation)
- [Generic Queries](#generic-queries)
- [Fuel Analysis](#fuel-analysis)
- [Customer Analysis](#customer-analysis)
- [Sales Metrics](#sales-metrics)
- [Usage](#usage)
- [License](#license)

## Database and Table Creation

The initial setup involves creating a database and a table for storing sales transactions:

```sql
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
