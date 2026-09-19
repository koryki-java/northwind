-- AND : orders with freight within bounds (two comparisons).
SELECT
  o.order_id
, o.freight
FROM
 orders o
WHERE
  o.freight < 100
 AND
  o.freight > 10
ORDER BY
  o.order_id ASC
LIMIT 20