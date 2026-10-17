-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, b.ordinal
, b.item
FROM
 check_complex t
  INNER JOIN UNNEST(CAST((t.doc -> '$.a.b') AS INTEGER[])) WITH ORDINALITY AS b(item, ordinal) ON TRUE