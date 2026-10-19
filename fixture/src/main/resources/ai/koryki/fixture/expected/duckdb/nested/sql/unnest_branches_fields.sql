-- One row per branch of a native list of structs, with its fields and a field of the struct inside.
-- A branch without a position has an empty latitude, not a JSON null.
SELECT
  t.nr
, b.item['street']
, b.item['city']
, b.item['zip']
, b.item['geo']['lat'] AS latitude
FROM
 check_complex t
  INNER JOIN UNNEST(t.branches) AS b(item) ON TRUE