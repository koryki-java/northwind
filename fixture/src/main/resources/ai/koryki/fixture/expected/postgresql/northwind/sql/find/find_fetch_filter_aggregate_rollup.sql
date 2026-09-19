-- filter, aggregate and group
SELECT
  c.country AS country
, count(c.customer_id) AS cnt
FROM
 customers c
GROUP BY ROLLUP (
  c.country)
HAVING
  count(c.customer_id) > 10