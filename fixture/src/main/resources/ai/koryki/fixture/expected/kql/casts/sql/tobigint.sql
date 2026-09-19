SELECT
  p.product_name
, CAST(p.units_in_stock AS BIGINT) AS stock_bigint
FROM
 products p
