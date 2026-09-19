SELECT
  p.product_name
, CAST(p.units_in_stock AS SIGNED) AS stock_bigint
FROM
 products p