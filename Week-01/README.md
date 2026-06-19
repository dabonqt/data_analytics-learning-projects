# Ecommerce Sales Dashboard — Power BI

## Task: Create Interactive Dashboard 

**Internship:** DataX Labs — Day 3 
**Author:** Lord Davon Mendoza  
**Dataset:** `ecommerce_sales_data.csv` 
**Tools:** Power BI(DAX,PowerQuery)

---

## Project Workflow

### 1. Data Preparation

The dataset was prepared using **Power Query** to ensure the data was clean, structured, and ready for analysis.

Key steps included:

- Reviewing and validating data types
- Cleaning and transforming data
- Preparing fields for reporting and analysis
- Organizing the dataset for efficient dashboard development

---

### 2. Data Modeling and Calculations

After preparing the data, custom measures were created using **DAX** to support dashboard calculations.

#### Measures Created

```DAX
Total Sales =
SUM(ecommerce_sales_data[Sales Amount])

Total Profit =
SUM(ecommerce_sales_data[Profit])

Profit Margin % =
DIVIDE([Total Profit], [Total Sales], 0)
```

These measures were used throughout the dashboard to provide consistent and dynamic business metrics.

---

### 3. Dashboard Development

The dashboard consists of three report pages:

---

## Overview Page

The Overview page provides a high-level summary of business performance through KPI cards and trend visualizations.

### Visualizations

- KPI Cards
  - Total Orders
  - Total Profit
  - Total Sales
  - Profit Margin %

- Total Sales by Month and Year
- Total Sales by Region
- Total Sales and Total Profit by Category

### Key Takeaway

> **"$10.67M in sales and a steady 17.3% margin — but 2024 cooled off after 2023's peak."**

---

## Product Performance Page

The Product Performance page focuses on analyzing how individual products contribute to overall sales and profitability.

### Visualizations

- Total Sales by Product Name
- Profit Margin % by Product Name
- Quantity vs. Profit Scatter Plot

### Key Takeaway

> **"No single product dominates — sales and margin are spread evenly across the lineup."**

---

## Regional Performance Page

The Regional Performance page highlights sales trends across different regions and categories.

### Visualizations

- Monthly Sales Matrix by Region
- Total Sales by Region and Category
- Total Sales by Region and Year

### Key Takeaway

> **"The West region leads overall, but no region or category owns every month."**

---

## Key Insights

### Overview

- Generated **$10.67M** in total sales.
- Achieved a **17.3% profit margin**.
- Sales performance peaked in **2023** before softening in **2024**.

### Products

- Revenue is distributed fairly evenly across products.
- No single product overwhelmingly drives sales or profit.
- Product performance remains balanced across the catalog.

### Regions

- The **West** region recorded the highest overall sales.
- Regional performance remains competitive across all regions.
- Sales leadership changes depending on category and time period.

---

## Conclusion

This project demonstrates the use of **Power Query** for data preparation and **DAX** for creating business metrics within Power BI. Through interactive reporting and data visualization, the dashboard provides a clear view of sales performance, profitability, product trends, and regional contributions.

---
