-- FIND with list of links with alias
SELECT
  c.category_name
, sum(ROUND(ROUND(od.unit_price, 8) * ROUND(od.quantity, 8), 8))
FROM
 orders o
  INNER JOIN order_details od ON
   o.order_id = od.order_id
    INNER JOIN products p ON
     od.product_id = p.product_id
      INNER JOIN categories c ON
       p.category_id = c.category_id
WHERE
  o.order_date >= '2023-01-01'
 AND
  o.order_date < '2024-01-01'
GROUP BY
  c.category_name
ORDER BY
  sum(ROUND(ROUND(od.unit_price, 8) * ROUND(od.quantity, 8), 8)) DESC