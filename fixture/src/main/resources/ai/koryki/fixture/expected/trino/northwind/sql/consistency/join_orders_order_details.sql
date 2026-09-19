SELECT
  o.order_id
, count(o.order_id)
FROM
 order_details d
  INNER JOIN orders o ON
   d.order_id = o.order_id
GROUP BY
  o.order_id
HAVING
  count(o.order_id) > 1