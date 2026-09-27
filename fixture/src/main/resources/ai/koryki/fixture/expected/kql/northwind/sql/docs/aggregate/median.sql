-- median: the middle unit price of each category's products, once sorted.
SELECT
  c.category_name
, MEDIAN(p.unit_price) AS median_price
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
GROUP BY
  c.category_name