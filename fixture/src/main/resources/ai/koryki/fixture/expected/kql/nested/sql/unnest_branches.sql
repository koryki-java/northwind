-- One row per branch of a native list of structs, with its position and its fields. Oracle has no
-- position for the elements of a collection, so it refuses this one: unnest_branches_fields asks the
-- same without it.
SELECT
  t.nr
, b.ordinal
, b.item['street']
, b.item['city']
, b.item['zip']
FROM
 check_complex t
  INNER JOIN UNNEST(t.branches) WITH ORDINALITY AS b(item, ordinal) ON TRUE