-- countries with more than 10 customers
SELECT
  c.country AS country
, count(c.customer_id) AS cnt
FROM
 customers c
GROUP BY
  c.country
HAVING
  count(c.customer_id) > 10