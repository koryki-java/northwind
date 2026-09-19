-- FIND join with composite key
SELECT
  sum(od1.unit_price * od2.quantity)
FROM
 order_details od1
  INNER JOIN order_details od2 ON
   od1.order_id = od2.order_id
  AND
   od1.product_id = od2.product_id
ORDER BY
  sum(od1.unit_price * od2.quantity) DESC