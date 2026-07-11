-- # Orders Data Validation Check

--To check the table
SELECT * FROM `dataxlabs-internship.orders.orders`

-- # Orders Data Validation Check

-- To check for nulls
SELECT
 COUNT(*) AS total_rows,
 COUNTIF(quantity IS NULL) AS quantity_nulls,
 ROUND(COUNTIF(quantity IS NULL) * 100.0/COUNT(*),2) AS quantity_null_pct,
 
 COUNTIF(payment_method IS NULL) AS payment_nulls,
 ROUND(COUNTIF(payment_method IS NULL) * 100.0/COUNT(*),2) AS payment_null_pct

FROM `dataxlabs-internship.orders.orders`


-- To check for duplicate orders
SELECT
  order_id,
  COUNT(*) AS records
FROM `dataxlabs-internship.orders.orders`
GROUP BY order_id
HAVING COUNT(*) > 1

-- To check for blank strings
SELECT
  COUNTIF(TRIM(payment_method) = '') AS blank_payment
FROM `dataxlabs-internship.orders.orders`


-- To check date ranges
SELECT
  MIN(order_date) AS min_order,
  MAX(order_date) AS max_order
FROM `dataxlabs-internship.orders.orders`
