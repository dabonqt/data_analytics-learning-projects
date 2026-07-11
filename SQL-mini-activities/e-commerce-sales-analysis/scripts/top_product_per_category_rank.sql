SELECT
  category,
  product_name,
  total_revenue,
  revenue_rank
FROM(
  SELECT
    p.category,
    p.product_name,
    SUM(o.quantity * p.price) AS total_revenue,
    ROW_NUMBER() OVER (
      PARTITION BY p.category
      ORDER BY SUM(o.quantity * p.price) DESC) AS revenue_rank
  FROM `dataxlabs-internship.orders.orders` o
  JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
  GROUP BY p.category, p.product_name
) AS ranked
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;