SELECT
  p.product_name
, CAST(p.units_in_stock AS NUMBER(19)) AS stock_bigint
FROM
 products p