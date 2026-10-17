-- The list of an element is read from the rows of the earlier unnest.
SELECT
  t.nr
, i.item['sku']
, o.item
FROM
 check_complex t
  INNER JOIN UNNEST(t.items) AS i(item) ON TRUE
    INNER JOIN UNNEST(i.item['opts']) AS o(item) ON TRUE