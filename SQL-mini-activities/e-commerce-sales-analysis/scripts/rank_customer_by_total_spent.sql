SELECT
  customer_id,
  city,
  total_revenue,
  DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS overall_rank,
  DENSE_RANK() OVER (PARTITION BY city ORDER BY total_revenue DESC) AS rank_in_city
FROM(
    SELECT
      c.customer_id,
      c.city,
      ROUND(SUM(o.quantity * p.price),2) AS total_revenue
      FROM `dataxlabs-internship.orders.orders` o
      JOIN `dataxlabs-internship.customer.customer` c ON o.customer_id = c.customer_id
      JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
      GROUP BY c.customer_id, c.city
) AS customer_revenue
ORDER BY overall_rank;

