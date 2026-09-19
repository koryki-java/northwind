-- > : orders with freight above a threshold.
SELECT
  o.order_id
, o.freight
FROM
 orders o
WHERE
  o.freight > 100
ORDER BY
  o.order_id ASC
LIMIT 20