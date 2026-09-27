-- quantile_cont: the price a quarter of the way up each category's sorted unit prices, interpolated.
SELECT
  c.category_name
, PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY p.unit_price) AS lower_quartile
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
GROUP BY
  c.category_name