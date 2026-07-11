-- 3 table join
CREATE OR REPLACE VIEW `dataxlabs-internship.orders.view` AS 

SELECT
    o.order_id,
    o.order_date,
    o.customer_id,
    c.city,
    c.gender,
    c.loyalty_member,
    p.product_name,
    p.category,
    p.price,
    o.quantity,
    o.quantity * p.price AS revenue,
    o.payment_method
FROM `dataxlabs-internship.orders.orders` o
JOIN `dataxlabs-internship.customer.customer` c ON o.customer_id = c.customer_id
JOIN `dataxlabs-internship.products.product` p ON o.product_id = p.product_id;

