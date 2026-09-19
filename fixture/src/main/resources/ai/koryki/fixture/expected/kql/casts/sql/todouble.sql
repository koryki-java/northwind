SELECT
  p.product_name
, CAST(p.unit_price AS DOUBLE) AS price_double
FROM
 products p
