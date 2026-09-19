-- Unary minus: negated field and negated arithmetic expression in FETCH.
SELECT
  od.order_id
, -od.discount
, -(od.unit_price * od.quantity)
FROM
 order_details od
  INNER JOIN orders o ON
   od.order_id = o.order_id
WHERE
  od.discount > 0
 AND
  o.customer_id = 'VINET'