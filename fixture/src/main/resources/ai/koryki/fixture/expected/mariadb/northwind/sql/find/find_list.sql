-- FIND with list of links without alias
SELECT
  c.category_name
, sum(CAST(CAST(od.unit_price AS DECIMAL(18, 6)) * CAST(od.quantity AS DECIMAL(18, 6)) AS DECIMAL(18, 6)))
FROM
 orders o
  INNER JOIN order_details od ON
   o.order_id = od.order_id
    INNER JOIN products p ON
     od.product_id = p.product_id
      INNER JOIN categories c ON
       p.category_id = c.category_id
WHERE
  o.order_date >= DATE '2023-01-01'
 AND
  o.order_date < DATE '2024-01-01'
GROUP BY
  c.category_name
ORDER BY
  sum(CAST(CAST(od.unit_price AS DECIMAL(18, 6)) * CAST(od.quantity AS DECIMAL(18, 6)) AS DECIMAL(18, 6))) DESC