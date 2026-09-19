-- NOT : orders whose freight is not above a threshold.
SELECT
  o.order_id
, o.freight
FROM
 orders o
WHERE
  NOT (o.freight > 100)
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY