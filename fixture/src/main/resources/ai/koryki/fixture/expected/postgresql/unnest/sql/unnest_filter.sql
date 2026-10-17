-- A filter on the rows of an inner unnest keeps the matching elements.
SELECT
  t.nr
, i.sku
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.items) AS i(sku, qty, price, opts) ON TRUE
WHERE
  i.qty > 1