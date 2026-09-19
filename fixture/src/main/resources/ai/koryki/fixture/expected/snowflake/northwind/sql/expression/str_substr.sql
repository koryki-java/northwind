SELECT
  substring(c.company_name, 1, 7) AS prefix
, substring(c.city, 1, 3) AS city_prefix
FROM
 customers c
WHERE
  c.customer_id = 'ALFKI'