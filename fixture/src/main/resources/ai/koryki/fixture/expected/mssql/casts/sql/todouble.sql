SELECT
  p.product_name
, CAST(p.unit_price AS FLOAT) AS price_double
FROM
 products p