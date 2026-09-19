-- count_distinct: how many different customers ordered from each country — not how many orders,
-- which is what plain count would give. The one function every BI tool exposes under its own name.
SELECT
  c.country
, COUNT(DISTINCT c.customer_id) AS customers
, count(o.order_id) AS orders
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
GROUP BY
  c.country