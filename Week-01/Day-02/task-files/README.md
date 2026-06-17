# Sales Dashboard — Power BI

## Task: Data Cleaning & Preprocessing

**Internship:** DataX Labs — Day 2  
**Author:** Lord Davon Mendoza  
**Dataset:** `sales_data.csv` (Customer Personality Analysis)  
**Tools:** Python, Pandas, Google Colab

## Tools Used

- Power BI Desktop
- Power Query
- DAX (Data Analysis Expressions)

---

## Data Preparation

Before creating the dashboard, the dataset was cleaned and transformed using Power Query.

### Tasks Performed

- Renamed columns for better readability
- Checked and verified data types
- Created a **Profit** column
- Created a **Year-Month** field for trend analysis

---

## Data Modeling & DAX

The following measures were created using DAX:

```DAX
Total Sales = SUM(sales_data[Sales])

Total Profit = SUM(sales_data[Profit])

Total Quantity Sold = SUM(sales_data[Quantity_Sold])

Total Orders = COUNTROWS(sales_data)

Profit Margin % =
DIVIDE([Total Profit], [Total Sales], 0)
```

These measures served as the foundation for the dashboard KPIs and visualizations.

---

## Dashboard Visualizations

The dashboard was designed to provide a high-level overview of business performance through interactive and easy-to-understand visuals.

### KPI Cards
- Total Sales
- Total Profit
- Total Quantity Sold
- Total Orders
- Profit Margin %

### Trend Analysis
- Sales Trend by Month
- Profit Trend by Month

### Performance Analysis
- Sales by Product Category
- Sales by Region
- Sales Representative Performance

### Distribution Analysis
- Sales Channel Distribution (Retail vs Online)

### Interactive Filters
- Month-Year
- Product Category
- Region

---

## Dashboard Preview


![Sales Dashboard](task-files/dashboard.png)


---

## Key Insights

### 1. High Sales, Significant Losses

The business generated approximately **$5.02M in sales**, but recorded a total profit of **-$58.82M**, resulting in a negative profit margin. This suggests that operational costs significantly exceeded revenue.

### 2. Clothing Was the Top Revenue Contributor

Among all product categories, **Clothing** generated the highest sales, making it the strongest revenue-driving category in the dataset.

### 3. Sales Channels Were Evenly Distributed

Retail contribute more sales than Online in slim margin, making them almost equal to total revenue, indicating balanced customer engagement across both channels.

---

## Key Takeaway

While the business demonstrated strong sales performance, profitability remains a major concern. The dashboard highlights the importance of analyzing both revenue and profit metrics when evaluating business performance.

---

## Learning Outcomes

Through this project, I gained hands-on experience in:

- Data cleaning and transformation using Power Query
- Creating calculated measures with DAX
- Designing interactive dashboards in Power BI
- Applying data storytelling techniques to communicate insights effectively

