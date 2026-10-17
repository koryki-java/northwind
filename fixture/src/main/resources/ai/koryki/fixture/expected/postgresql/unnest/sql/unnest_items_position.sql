-- The position of the element in its list, from 1. Oracle has none for a collection in a lateral join.
SELECT
  t.nr
, i.ordinal
, i.sku
, i.qty * i.price AS total
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.items) WITH ORDINALITY AS i(sku, qty, price, opts, ordinal) ON TRUE