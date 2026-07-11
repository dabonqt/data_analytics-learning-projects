-- # Customer Data Validation Check

-- To check for nulls
SELECT
 COUNT(*) AS total_rows,
 COUNTIF(gender IS NULL) AS gender_nulls,
 ROUND(COUNTIF(gender IS NULL) * 100.0/COUNT(*),2) AS gender_null_pct,

 COUNTIF(age IS NULL) AS age_nulls,
 ROUND(COUNTIF(age IS NULL) * 100.0/COUNT(*),2) AS age_null_pct,
 COUNTIF(city IS NULL) AS city_null
FROM `dataxlabs-internship.customer.customer`


-- To check for duplicate customers
SELECT
  customer_id,
  COUNT(*) AS records
FROM `dataxlabs-internship.customer.customer`
GROUP BY customer_id
HAVING COUNT(*) > 1

-- To check for blank strings
SELECT
  COUNTIF(TRIM(gender) = '') AS blank_gender,
  COUNTIF(TRIM(city) = '') AS blank_city
FROM `dataxlabs-internship.customer.customer`

-- To check for invalid ages
SELECT
  MIN(age) AS min_age,
  MAX(age) AS max_age
FROM `dataxlabs-internship.customer.customer`

-- To check date ranges
SELECT
  MIN(signup_date) AS earliest_signup,
  MAX(signup_date) AS latest_signup
FROM `dataxlabs-internship.customer.customer`

-- To validate loyalty member values
SELECT
  loyalty_member,
  COUNT(*) AS total
FROM `dataxlabs-internship.customer.customer`
GROUP BY loyalty_member

-- To check for city variations
SELECT
  city,
  COUNT(*) AS total
FROM `dataxlabs-internship.customer.customer`
GROUP BY city
ORDER BY city DESC
