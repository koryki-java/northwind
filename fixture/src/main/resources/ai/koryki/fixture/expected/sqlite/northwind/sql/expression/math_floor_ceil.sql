SELECT
  p.product_name
, floor(p.unit_price) AS price_floor
, ceil(p.unit_price) AS price_ceil
FROM
 products p
WHERE
  p.product_id = 1