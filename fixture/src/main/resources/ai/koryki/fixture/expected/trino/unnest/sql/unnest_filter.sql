-- A filter on the rows of an inner unnest keeps the matching elements.
SELECT
  t.nr
, i.sku
FROM
 check_complex t
  CROSS JOIN UNNEST(t.items) AS i(sku, qty, price, opts)
WHERE
  i.qty > 1