-- row_number: number each customer's orders from their earliest, without collapsing any rows.
SELECT
  c.customer_id
, o.order_id
, row_number() OVER (PARTITION BY c.customer_id ORDER BY o.order_id) AS nth
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  c.country = 'France'