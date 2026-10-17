-- The position of the element in its list, from 1. Oracle has none for a collection in a lateral join.
SELECT
  t.nr
, i.ordinal
, i.item['sku']
, i.item['qty'] * i.item['price'] AS total
FROM
 check_complex t
  INNER JOIN UNNEST(t.items) WITH ORDINALITY AS i(item, ordinal) ON TRUE