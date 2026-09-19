-- A customer's region is frequently missing — fall back to the country for display.
-- coalesce returns the first non-null of its arguments.
SELECT
  c.customer_id
, c.company_name
, coalesce(c.region, c.country) AS region_or_country
FROM
 customers c
ORDER BY
  c.customer_id ASC