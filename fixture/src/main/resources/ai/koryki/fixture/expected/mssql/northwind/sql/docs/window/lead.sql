-- lead: the mirror of lag — the next order's freight for the same customer.
SELECT
  c.customer_id
, o.order_id
, o.freight
, lead(o.freight) OVER (PARTITION BY c.customer_id ORDER BY o.order_id) AS next_freight
FROM
 customers c
  INNER JOIN orders o ON
   c.customer_id = o.customer_id
WHERE
  c.country = 'France'