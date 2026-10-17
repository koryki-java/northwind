-- The list of an element is read from the rows of the earlier unnest.
SELECT
  t.nr
, i.sku
, o.value
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.items) AS i(sku, qty, price, opts) ON TRUE
    INNER JOIN LATERAL unnest(i.opts) AS o(value) ON TRUE