SELECT
  count(c.company_name) OVER (PARTITION BY d.unit_price ORDER BY c.company_name ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
, sum(d.unit_price * d.quantity) AS sum
FROM
 order_details d
  INNER JOIN orders o ON
   d.order_id = o.order_id
    INNER JOIN customers c ON
     o.customer_id = c.customer_id
