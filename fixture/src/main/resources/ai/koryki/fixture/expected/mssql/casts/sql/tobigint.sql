SELECT
  p.product_name
, CAST(ROUND(p.units_in_stock, 0) AS BIGINT) AS stock_bigint
FROM
 products p