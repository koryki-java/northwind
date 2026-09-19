SELECT
  sum(ROUND(ROUND(d.unit_price, 12) * ROUND(d.quantity, 12), 12)) OVER (PARTITION BY c.company_name) AS sum
, count(c.company_name) OVER (PARTITION BY ROUND(d.unit_price, 12) ORDER BY c.company_name ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM
 order_details d
  INNER JOIN orders o ON
   d.order_id = o.order_id
    INNER JOIN customers c ON
     o.customer_id = c.customer_id
WHERE
  c.company_name LIKE 'A%'