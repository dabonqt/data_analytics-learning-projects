SELECT
  c.customer_id,
  c.city,
  c.loyalty_member,
  COUNT(o.order_id) AS total_orders,
  ROUND(SUM(o.quantity * p.price),2)   AS total_revenue,
  ROUND(AVG(o.quantity * p.price),2)   AS avg_order_value  
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customer.customer` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.city, c.loyalty_member
ORDER BY total_revenue DESC;