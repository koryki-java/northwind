SELECT
  o.order_date
, sum(od.unit_price * od.quantity * (1 - od.discount)) AS total
FROM
 orders o
  INNER JOIN order_details od ON
   o.order_id = od.order_id
WHERE
  o.customer_id = 'SUPRD'
GROUP BY
  o.order_date