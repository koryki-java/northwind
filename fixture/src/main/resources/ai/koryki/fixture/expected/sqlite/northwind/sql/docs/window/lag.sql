-- lag: each order alongside the previous order's freight for the same customer — the shape behind
-- "compare with the period before".
SELECT
  c.customer_id
, o.order_id
, o.freight
, lag(o.freight) OVER (PARTITION BY c.customer_id ORDER BY o.order_id) AS previous_freight
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  c.country = 'France'