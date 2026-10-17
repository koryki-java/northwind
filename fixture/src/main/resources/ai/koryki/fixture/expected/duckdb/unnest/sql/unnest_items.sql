-- A list of structs made into rows: one row for each element, with its fields as columns.
SELECT
  t.nr
, i.item['sku']
, i.item['qty'] * i.item['price'] AS total
FROM
 check_complex t
  INNER JOIN UNNEST(t.items) AS i(item) ON TRUE