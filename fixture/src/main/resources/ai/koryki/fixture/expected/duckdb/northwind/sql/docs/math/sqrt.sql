-- sqrt: square root of freight.
SELECT
  o.order_id
, sqrt(o.freight) AS root
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY