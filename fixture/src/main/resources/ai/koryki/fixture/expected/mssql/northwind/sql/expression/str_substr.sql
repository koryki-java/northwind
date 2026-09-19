SELECT
  SUBSTRING(c.company_name, 1, 7) AS prefix
, SUBSTRING(c.city, 1, 3) AS city_prefix
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'