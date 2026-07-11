SELECT
  c.city,
  p.category,
  COUNT(o.order_id) AS total_orders,
  ROUND(SUM(o.quantity 
      * p.price),2) AS total_revenue,
  ROUND(AVG(p.price),2) AS avg_product_price          
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customer.customer` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id
GROUP BY c.city, p.category
ORDER BY c.city, total_revenue DESC;
