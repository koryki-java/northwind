-- case: classify orders by freight.
SELECT
  o.order_id
, CASE WHEN o.freight > 100 THEN 'high' ELSE 'low' END AS freight_tier
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY