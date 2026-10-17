-- The outer form keeps the row whose list is empty or NULL, with NULLs for the element.
SELECT
  t.nr
, i.item['sku']
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(t.items) AS i(item) ON TRUE