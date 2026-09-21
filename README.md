# E-Commerce Sales & Profitability Analysis | Excel, SQL & Power BI

## 📌 Project Overview

This project analyzes e-commerce sales data to understand sales performance, profitability, customer purchasing patterns, product performance, and business trends.

The project uses **Excel, SQL Server, and Power BI** to perform data cleaning, data analysis, business analysis, and interactive visualization.

---

## 🎯 Project Objective

The main objectives of this project are:

- Analyze overall sales and profit performance
- Identify high-performing product categories and sub-categories
- Analyze monthly sales and profit trends
- Understand customer purchasing patterns
- Analyze state-wise and city-wise performance
- Compare different payment modes
- Identify profitable and loss-making sub-categories
- Rank customers and sub-categories based on performance
- Calculate category-level profit margins
- Present insights through an interactive Power BI dashboard

---

## 🛠️ Tools & Technologies

- **Microsoft Excel**
- **SQL Server**
- **Power BI**
- **Power Query**
- **DAX**
- **Data Cleaning**
- **Data Analysis**
- **Data Visualization**

---

## 📂 Dataset

The project uses two datasets:

### Orders
Contains information related to:

- Order ID
- Order Date
- Customer Name
- State
- City

### Details
Contains information related to:

- Order ID
- Amount
- Profit
- Quantity
- Category
- Sub-Category
- Payment Mode

The two tables are connected using **Order ID**.

---

# 🔹 Excel Analysis

Excel was used for data cleaning, validation, and preliminary business analysis.

### Excel Tasks

- Checked duplicate records
- Checked blank/missing values
- Validated date fields
- Validated numeric fields
- Prepared cleaned Orders and Details datasets
- Created KPI summary
- Performed category analysis
- Performed monthly analysis
- Performed customer analysis
- Performed sub-category analysis
- Created sales and trend charts

---

# 🔹 SQL Analysis

SQL Server was used for detailed business analysis and advanced querying.

### SQL Concepts Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `INNER JOIN`
- Aggregate Functions
- `CASE WHEN`
- CTEs
- `RANK()` Window Function
- `COUNT(DISTINCT)`
- Profit Margin Calculation

### SQL Analysis Performed

- Overall business KPIs
- Monthly sales and profit analysis
- Category performance
- Sub-category performance
- State-wise analysis
- City-wise analysis
- Top customers by sales
- Payment mode analysis
- Profitability status
- Sub-category profit ranking
- Customer sales ranking
- Category profit margin analysis

---

# 🔹 Power BI Dashboard

Power BI was used to create an interactive dashboard for visualizing business performance.

### Dashboard Analysis

- Total Sales
- Total Profit
- Total Quantity
- Total Orders
- Sales Performance
- Profit Performance
- Category Analysis
- Customer Analysis
- Product/Sub-category Analysis
- Business Trends

The dashboard allows users to explore the data interactively and identify important business patterns.

---

## 📊 Key Business Metrics

The analysis identified the following overall metrics:

| Metric | Value |
|---|---:|
| Total Sales | ₹437,771 |
| Total Profit | ₹36,963 |
| Total Quantity | 5,615 |
| Total Orders | 500 |
| Total Customers | 336 |

---

## 📈 Key Analysis Areas

### Category Performance

The analysis compares:

- Sales
- Profit
- Quantity
- Profit Margin

across Electronics, Clothing, and Furniture categories.

### Monthly Performance

Monthly sales and profit were analyzed to understand changes in business performance throughout the year.

### Customer Analysis

Customers were analyzed based on:

- Total Sales
- Total Profit
- Total Quantity

Customers were also ranked according to their total sales.

### Product Analysis

Sub-categories were analyzed based on:

- Sales
- Profit
- Quantity
- Profitability status
- Profit ranking

### Geographic Analysis

Sales and profit were analyzed across:

- States
- Cities

### Payment Analysis

Different payment modes were compared using sales, profit, quantity, and order count.

---

## 📁 Project Files

```text
E-Commerce Sales Analysis
│
├── Orders.csv
├── Details.csv
├── Ecommerce_Sales_Analysis_Excel_FIXED.xlsx
├── SQL_Analysis.sql
├── ECOMMERCE SALES DASHBOARD USING POWER BI.pbix
└── README.mdthusiast
