SELECT
  p.product_name
, CAST(p.unit_price AS VARCHAR(MAX)) AS unit_price_text
FROM
 products p