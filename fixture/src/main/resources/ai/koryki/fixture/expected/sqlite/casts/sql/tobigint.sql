SELECT
  p.product_name
, CAST(ROUND(p.units_in_stock, 0) AS INTEGER) AS stock_bigint
FROM
 products p