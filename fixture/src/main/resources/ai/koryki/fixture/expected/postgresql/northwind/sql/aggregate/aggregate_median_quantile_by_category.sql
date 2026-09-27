-- test
SELECT
  c.category_name
, PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY p.unit_price) AS median_price
, PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY p.unit_price) AS q1_cont
, PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY p.unit_price) AS q1_disc
, PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY p.unit_price) AS q3_cont
, PERCENTILE_DISC(0.75) WITHIN GROUP (ORDER BY p.unit_price) AS q3_disc
, count(p.product_id) AS n
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
GROUP BY
  c.category_name
ORDER BY
  c.category_name ASC