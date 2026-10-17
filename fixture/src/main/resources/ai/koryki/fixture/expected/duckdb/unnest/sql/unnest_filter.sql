-- A filter on the rows of an inner unnest keeps the matching elements.
SELECT
  t.nr
, i.item['sku']
FROM
 check_complex t
  INNER JOIN UNNEST(t.items) AS i(item) ON TRUE
WHERE
  i.item['qty'] > 1