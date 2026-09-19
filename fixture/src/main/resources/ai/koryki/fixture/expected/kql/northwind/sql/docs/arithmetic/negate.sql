-- negate (-): arithmetic negation of freight.
SELECT
  o.order_id
, -o.freight AS neg_freight
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY