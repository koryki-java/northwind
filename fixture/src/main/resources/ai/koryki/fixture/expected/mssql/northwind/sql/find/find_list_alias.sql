-- FIND with list of links with alias
SELECT
  c.category_name
, sum(CAST(CAST(od.unit_price AS DECIMAL(32, 8)) * CAST(od.quantity AS DECIMAL(32, 8)) AS DECIMAL(32, 8)))
FROM
 orders o
  INNER JOIN order_details od ON
   o.order_id = od.order_id
    INNER JOIN products p ON
     od.product_id = p.product_id
      INNER JOIN categories c ON
       p.category_id = c.category_id
WHERE
  o.order_date >= CAST('2023-01-01' AS DATE)
 AND
  o.order_date < CAST('2024-01-01' AS DATE)
GROUP BY
  c.category_name
ORDER BY
  sum(CAST(CAST(od.unit_price AS DECIMAL(32, 8)) * CAST(od.quantity AS DECIMAL(32, 8)) AS DECIMAL(32, 8))) DESC