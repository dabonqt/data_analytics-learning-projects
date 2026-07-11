-- # Product Data Validation Check

-- To check the table
SELECT  
  *
FROM `dataxlabs-internship.products.product`

-- To check for the nulls and missing values
SELECT
  COUNT(*) AS total_rows,
  COUNTIF(product_name IS NULL) as null_products,
  ROUND(COUNTIF(product_name IS NULL) * 100.0/ COUNT(*),2) AS null_products_pct,

  COUNTIF(category IS NULL) AS null_categories,
  ROUND(COUNTIF(category IS NULL) * 100.0 / COUNT(*),2) AS null_category_pct,

  COUNTIF(price IS NULL) AS null_prices,
  COUNTIF(price < 0) AS negative_prices
FROM `dataxlabs-internship.products.product`


-- To check for duplicate values
SELECT
 product_id,
 COUNT(*) AS total
FROM `dataxlabs-internship.products.product`
GROUP BY product_id
HAVING COUNT(*) > 1

-- To check the price range
SELECT
  MIN(price) AS lowest_price,
  MAX(price) AS highest_price
FROM `dataxlabs-internship.products.product`
