SELECT
  p.product_name
, round(p.unit_price, 0) AS price_rounded
, abs(p.unit_price - 20) AS diff_from_20
FROM
 products p
WHERE
  p.product_name = 'Chai'