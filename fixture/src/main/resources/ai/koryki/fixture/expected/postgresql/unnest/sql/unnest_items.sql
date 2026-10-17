-- A list of structs made into rows: one row for each element, with its fields as columns.
SELECT
  t.nr
, i.sku
, i.qty * i.price AS total
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.items) AS i(sku, qty, price, opts) ON TRUE