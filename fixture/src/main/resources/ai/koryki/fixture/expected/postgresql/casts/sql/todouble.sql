SELECT
  p.product_name
, CAST(p.unit_price AS DOUBLE PRECISION) AS price_double
FROM
 products p