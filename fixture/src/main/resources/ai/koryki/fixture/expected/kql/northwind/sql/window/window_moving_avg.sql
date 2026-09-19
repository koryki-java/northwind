-- Moving average: 3-row sliding average of price within each category.
-- ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING includes the row before, the
-- current row, and the row after — so the window slides across sorted prices.
SELECT
  c.category_name
, p.unit_price
, p.product_name
, avg(p.unit_price) OVER (PARTITION BY c.category_name ORDER BY p.unit_price, p.product_name ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg_price
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
ORDER BY
  c.category_name ASC
, p.unit_price ASC