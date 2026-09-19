-- filter, aggregate and group
SELECT
  c.country AS country
, count(c.customer_id) AS cnt
FROM
 customers c
WHERE
  c.company_name LIKE 'abc%'
GROUP BY
  c.country
HAVING
  count(c.customer_id) > 10