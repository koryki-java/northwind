-- A query without agg is returned as it is.
SELECT
  c.country
, count(c.customer_id) AS customers
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
    INNER JOIN order_details od ON
     o.order_id = od.order_id
WHERE
  c.country = 'Germany'
GROUP BY
  c.country