-- negate (-): arithmetic negation of freight.
SELECT
  o.order_id
, -o.freight AS neg_freight
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY