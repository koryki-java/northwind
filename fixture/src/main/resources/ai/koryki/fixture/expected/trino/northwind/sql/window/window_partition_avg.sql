-- Partition average: compare each product's price to its category average.
-- OVER (PARTITION ...) with no ORDER and no frame spans the entire partition,
-- so avg() returns the same category-wide value for every row in that category.
SELECT
  c.category_name
, p.product_name
, p.unit_price
, avg(CAST(p.unit_price AS DOUBLE)) OVER (PARTITION BY c.category_name) AS category_avg_price
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
WHERE
  c.category_id IN (3, 4, 7)
ORDER BY
  c.category_name ASC
, p.product_name ASC