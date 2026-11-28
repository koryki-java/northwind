SELECT
  p.category_id AS category
, sum(CASE WHEN aggj1_2.country = 'Germany' THEN od.unit_price * od.quantity END) AS germany
, sum(od.quantity) AS units
FROM
 products p
  INNER JOIN order_details od ON
   p.product_id = od.product_id
    LEFT OUTER JOIN orders aggj1_1 ON
     od.order_id = aggj1_1.order_id
      LEFT OUTER JOIN customers aggj1_2 ON
       aggj1_1.customer_id = aggj1_2.customer_id
GROUP BY
  p.category_id