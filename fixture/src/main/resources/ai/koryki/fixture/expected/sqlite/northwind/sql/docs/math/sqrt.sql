-- sqrt: square root of freight.
SELECT
  o.order_id
, sqrt(o.freight) AS root
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20