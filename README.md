WALMART PROJECT
📌 Project Overview
This is an end-to-end data analysis project on Walmart Sales Data using Python (Pandas) for data cleaning and MySQL for solving real-world business problems through SQL queries.
The dataset contains 10,000+ transactions across 100 Walmart branches spread across multiple cities in the USA — covering sales from 2019 to 2023.

🎯 Objectives
Clean and preprocess raw Walmart sales data using Pandas
Load the cleaned data into MySQL Workbench
Solve 9 business problems using advanced SQL queries
Extract actionable insights on sales, revenue, ratings, and customer behaviour

🗂️ Project Structure
📁 Walmart-Sales-Analysis/
│
├── 📓 walmart_project.ipynb          # Python data cleaning (Pandas)
├── 📄 walmart_sql_business_solutions.sql  # All 9 SQL business queries
├── 📋 Walmart_Business_Problems.docx     # Business problem statements
├── 📊 Walmart.csv                         # Raw dataset
└── 📖 README.md                           # Project documentation

📊 Dataset Description
Column
Description
invoice_id
Unique transaction ID
Branch
Walmart branch code (e.g., WALM003)
City
City where branch is located
category
Product category
unit_price
Price per unit
quantity
Number of items sold
date
Transaction date
time
Transaction time
payment_method
Ewallet / Cash / Credit Card
rating
Customer rating (3.0 – 10.0)
profit_margin
Profit margin ratio
total
Total transaction value
Dataset Size: 10,051 rows × 12 columns
Branches: 100 unique branches
Cities: 98 unique cities
Categories: 6 product categories 

🛠️ Tools & Technologies
Tool
Purpose
Python 3
Data cleaning & preprocessing
Pandas
DataFrame operations, datatype conversion
Google Colab
Python notebook environment
MySQL 8.0
Database & SQL queries
MySQL Workbench
SQL IDE

🧹 Data Cleaning Steps (Python / Pandas)
The raw dataset had the following issues that were fixed:
unit_price had $ signs → removed and converted to FLOAT
date column was object type → converted to DATE
time column was object type → converted to TIME
quantity had float values → converted to INT
Calculated total column = unit_price × quantity
Removed duplicate rows
Handled null/missing values
import pandas as pd

df = pd.read_csv("Walmart.csv")

# Fix unit_price - remove $ sign
df['unit_price'] = df['unit_price'].str.replace('$','').astype(float)

# Fix datatypes
df['quantity']   = df['quantity'].astype(int)
df['rating']     = df['rating'].astype(float)
df['total']      = df['unit_price'] * df['quantity']

# Check
df.dtypes
df.info()

🗄️ Database Setup (MySQL)
CREATE DATABASE walmart;
USE walmart;

CREATE TABLE walmart (
    invoice_id    VARCHAR(30) PRIMARY KEY,
    branch        VARCHAR(10),
    city          VARCHAR(30),
    category      VARCHAR(100),
    unit_price    DECIMAL(10,2),
    quantity      INT,
    date          VARCHAR(20),
    time          VARCHAR(20),
    payment_method VARCHAR(30),
    rating        FLOAT,
    profit_margin FLOAT,
    total         DECIMAL(10,2)
);
