SELECT
  p.product_name
, length(p.product_name) AS name_len
FROM
 products p
WHERE
  p.product_name = 'Chai'