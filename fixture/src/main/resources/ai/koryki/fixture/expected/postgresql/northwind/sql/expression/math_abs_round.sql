SELECT
  p.product_name
, round(CAST(p.unit_price AS numeric), 0) AS price_rounded
, abs(p.unit_price - 20) AS diff_from_20
FROM
 products p
WHERE
  p.product_name = 'Chai'