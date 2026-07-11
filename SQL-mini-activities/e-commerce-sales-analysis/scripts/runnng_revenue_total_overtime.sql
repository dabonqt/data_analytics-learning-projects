SELECT
  order_month,
  monthly_revenue,
  SUM(monthly_revenue) OVER (ORDER BY order_month ROWS UNBOUNDED PRECEDING)
    AS running_total 
FROM(
  SELECT
    DATE_TRUNC(CAST(o.order_date AS DATE),MONTH) AS order_month,
    SUM(o.quantity * p.price) AS monthly_revenue
  FROM `dataxlabs-internship.orders.orders` o
  JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
  GROUP BY DATE_TRUNC(CAST(o.order_date AS DATE),MONTH)
) AS monthly
ORDER BY order_month;