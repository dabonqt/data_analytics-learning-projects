# SQL Data Analysis — Retail Sales Dataset
**DataX Labs Internship · Day 4**

**Author · Lord Davon Mendoza**

---

## Task

Use SQL queries to extract and analyze data from a relational database, applying aggregate functions to summarize and interpret sales performance across customers, orders, and products.

> **Note:** While the task guide focused on aggregate functions, I went further by incorporating window functions and nested queries — including `LAG`, `DENSE_RANK`, `ROW_NUMBER`, and `PARTITION BY` — to deepen my understanding of advanced SQL patterns and produce more nuanced analysis.

---

## Tools & Concepts Used

| Area | Details |
|---|---|
| **Platform** | BigQuery (GoogleSQL) |
| **Joins** | INNER JOIN across 3 tables |
| **Aggregate Functions** | `SUM`, `AVG`, `COUNT`, `GROUP BY` |
| **Window Functions** | `SUM() OVER`, `LAG()`, `DENSE_RANK()`, `ROW_NUMBER()`, `PARTITION BY` |
| **Other** | Subqueries, `NULLIF`, `DATE_TRUNC`, derived columns |

---

## Dataset

Three tables from a UK-based retail operation, covering **January 2023 – May 2024**.

| Table | Rows | Description |
|---|---|---|
| `customers` | 1,200 | Demographics: gender, age, city, signup date, loyalty membership |
| `orders` | 4,000 | Transactions: customer, product, date, quantity, payment method |
| `products` | 80 | Catalog: product name, category, unit price |

**Relationships:** `customers → orders` via `customer_id` · `orders → products` via `product_id`

---

## Queries Produced

### 1. Full Order Details — 3-Table JOIN
Enriches every order with customer demographics and product information. Introduces a derived `revenue` column (`quantity × price`) used as the foundation for all downstream analysis.

```sql
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.city,
    c.gender,
    c.loyalty_member,
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    o.quantity * p.price  AS revenue,
    o.payment_method
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customers.customers` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product`   p ON o.product_id  = p.product_id;
```

---

### 2. Total Revenue per Customer
Summarizes spend, order count, and average order value per customer. Useful for identifying high-value customers and loyalty patterns.

```sql
SELECT
    c.customer_id,
    c.city,
    c.loyalty_member,
    COUNT(o.order_id)            AS total_orders,
    SUM(o.quantity * p.price)    AS total_revenue,
    AVG(o.quantity * p.price)    AS avg_order_value
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customers.customers` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product`   p ON o.product_id  = p.product_id
GROUP BY
    c.customer_id, c.city, c.loyalty_member
ORDER BY
    total_revenue DESC;
```

---

### 3. Revenue by Category and City
Breaks down sales performance across all combinations of product category and customer city. Useful for regional assortment decisions.

```sql
SELECT
    c.city,
    p.category,
    COUNT(o.order_id)          AS total_orders,
    SUM(o.quantity * p.price)  AS total_revenue,
    ROUND(AVG(p.price), 2)     AS avg_product_price
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customers.customers` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product`   p ON o.product_id  = p.product_id
GROUP BY
    c.city, p.category
ORDER BY
    c.city, total_revenue DESC;
```

---

### 4. Customer Revenue Ranking — `DENSE_RANK` + `PARTITION BY`
Assigns two ranks per customer: one globally and one within their city. Demonstrates how `PARTITION BY` resets ranking logic per group without collapsing rows.

```sql
SELECT
    customer_id,
    city,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC)                        AS overall_rank,
    DENSE_RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC)      AS rank_within_city
FROM (
    SELECT
        c.customer_id,
        c.city,
        SUM(o.quantity * p.price) AS total_revenue
    FROM `dataxlabs-internship.orders.orders` o
    JOIN `dataxlabs-internship.customers.customers` c ON o.customer_id = c.customer_id
    JOIN `dataxlabs-internship.products.product`   p ON o.product_id  = p.product_id
    GROUP BY c.customer_id, c.city
) AS customer_revenue
ORDER BY overall_rank;
```

---

### 5. Running Revenue Total — `SUM() OVER`
Calculates cumulative revenue month by month. Uses `ROWS UNBOUNDED PRECEDING` to accumulate all prior rows up to the current month.

```sql
SELECT
    order_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY order_month ROWS UNBOUNDED PRECEDING)
        AS running_total
FROM (
    SELECT
        DATE_TRUNC(CAST(o.order_date AS DATE), MONTH) AS order_month,
        SUM(o.quantity * p.price)                      AS monthly_revenue
    FROM `dataxlabs-internship.orders.orders` o
    JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
    GROUP BY DATE_TRUNC(CAST(o.order_date AS DATE), MONTH)
) AS monthly
ORDER BY order_month;
```

---

### 6. Month-over-Month Revenue Change — `LAG`
Compares each month's revenue to the previous month's. Uses `NULLIF` on the denominator to safely handle any zero-revenue months and avoid divide-by-zero errors.

```sql
SELECT
    order_month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY order_month)  AS prev_month_revenue,
    monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY order_month)  AS revenue_change,
    ROUND(
        100.0 * (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY order_month))
              / NULLIF(LAG(monthly_revenue) OVER (ORDER BY order_month), 0),
        2
    ) AS pct_change
FROM (
    SELECT
        DATE_TRUNC(CAST(o.order_date AS DATE), MONTH) AS order_month,
        SUM(o.quantity * p.price)                      AS monthly_revenue
    FROM `dataxlabs-internship.orders.orders` o
    JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
    GROUP BY DATE_TRUNC(CAST(o.order_date AS DATE), MONTH)
) AS monthly
ORDER BY order_month;
```

---

### 7. Top Product per Category — `ROW_NUMBER`
Returns exactly one top-revenue product per category using the "rank then filter" pattern. `ROW_NUMBER` ensures a single winner even when totals are tied.

```sql
SELECT
    category,
    product_name,
    total_revenue,
    revenue_rank
FROM (
    SELECT
        p.category,
        p.product_name,
        SUM(o.quantity * p.price)                                     AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY p.category
            ORDER BY SUM(o.quantity * p.price) DESC
        )                                                              AS revenue_rank
    FROM `dataxlabs-internship.orders.orders` o
    JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
    GROUP BY p.category, p.product_name
) AS ranked
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;
```

---

## Key Learnings

- **3-table JOINs** chain outward from the table holding all foreign keys (`orders`), not from either of the dimension tables.
- **`GROUP BY` rule:** every non-aggregated column in `SELECT` must appear in `GROUP BY`.
- **Window functions vs. `GROUP BY`:** window functions compute across rows *without collapsing them*, making them ideal for ranks, running totals, and period comparisons.
- **`PARTITION BY`** acts as a reset boundary inside a window — the same role `GROUP BY` plays in aggregations.
- **Subquery wrapping** is required when filtering on a window function result, since window aliases are not available in the same `WHERE` clause.
- **BigQuery `DATE_TRUNC` syntax:** `DATE_TRUNC(date_expr, MONTH)` — date expression comes first, part is an unquoted keyword (differs from PostgreSQL's reversed-argument style).

---

*DataX Labs Internship · Data Analyst Track · Day 4*

