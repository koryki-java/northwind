-- The list of an element is read from the rows of the earlier unnest.
SELECT
  t.nr
, i.sku
, o.value
FROM
 check_complex t
  CROSS JOIN UNNEST(t.items) AS i(sku, qty, price, opts)
    CROSS JOIN UNNEST(i.opts) AS o(value)