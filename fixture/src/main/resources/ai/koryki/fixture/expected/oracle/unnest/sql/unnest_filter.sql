-- A filter on the rows of an inner unnest keeps the matching elements.
SELECT
  t.nr
, i.sku
FROM
 check_complex t
  CROSS APPLY TABLE(t.items) i
WHERE
  i.qty > 1