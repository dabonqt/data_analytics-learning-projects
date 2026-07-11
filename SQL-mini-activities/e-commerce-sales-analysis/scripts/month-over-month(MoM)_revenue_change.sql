SELECT
  order_month,
  monthly_revenue,
  LAG(monthly_revenue) OVER (ORDER BY order_month) AS prev_month_revenue,
  monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY order_month) AS revenue_change,

  ROUND(100.0 * (monthly_revenue - LAG(monthly_revenue)
	OVER (ORDER BY order_month) / NULLIF(LAG(monthly_revenue)
	OVER (ORDER BY order_month),0)),2) AS percent_change
FROM
(
  SELECT
    DATE_TRUNC(CAST(o.order_date AS DATE),MONTH) AS order_month,
    SUM(o.quantity * p.price) AS monthly_revenue
  FROM `dataxlabs-internship.orders.orders` o
  JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
  GROUP BY DATE_TRUNC(CAST(o.order_date AS DATE),MONTH)
  
) AS monthly
