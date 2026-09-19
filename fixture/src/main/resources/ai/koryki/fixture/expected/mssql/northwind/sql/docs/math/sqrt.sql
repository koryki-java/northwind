-- sqrt: square root of freight.
SELECT
  o.order_id
, sqrt(o.freight) AS root
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY