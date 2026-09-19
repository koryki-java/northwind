-- filter, aggregate and group
SELECT
  c.country AS country
, count(c.customer_id) AS cnt
FROM
 customers c
GROUP BY
  c.country WITH ROLLUP
HAVING
  count(c.customer_id) > 10