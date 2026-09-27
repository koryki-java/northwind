-- quantile_disc: like quantile_cont, but always one of the actual prices, never interpolated.
SELECT
  c.category_name
, PERCENTILE_DISC(0.25) WITHIN GROUP (ORDER BY p.unit_price) AS lower_quartile
FROM
 products p
  INNER JOIN categories c ON
   p.category_id = c.category_id
GROUP BY
  c.category_name