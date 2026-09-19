-- Unary minus: negative number literal in filter comparison.
-- All order details with unit price above -1 (unary minus on numeric literal).
SELECT
  od.order_id
, od.unit_price
FROM
 order_details od
  INNER JOIN orders o ON
   od.order_id = o.order_id
WHERE
  od.unit_price > -1
 AND
  o.customer_id = 'VINET'