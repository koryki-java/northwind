SELECT
  o.order_id
, p.product_name
, c.company_name
, ROUND(d.unit_price, 6)
, d.quantity
, ROUND(ROUND(d.unit_price, 6) * ROUND(d.quantity, 6), 6) AS product_total
, sum(ROUND(ROUND(d.unit_price, 6) * ROUND(d.quantity, 6), 6)) OVER (PARTITION BY o.order_id ORDER BY o.order_id) AS order_total
FROM
 order_details d
  INNER JOIN orders o ON
   d.order_id = o.order_id
    INNER JOIN customers c ON
     o.customer_id = c.customer_id
  INNER JOIN products p ON
   d.product_id = p.product_id
WHERE
  o.order_date >= '2023-01-01'
 AND
  o.order_date < '2024-01-01'
 AND
  c.company_name LIKE 'C%'
ORDER BY
  o.order_id ASC
, p.product_name ASC