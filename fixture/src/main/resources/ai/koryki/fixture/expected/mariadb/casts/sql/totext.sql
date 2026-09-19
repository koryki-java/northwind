SELECT
  p.product_name
, CAST(p.unit_price AS CHAR) AS unit_price_text
FROM
 products p