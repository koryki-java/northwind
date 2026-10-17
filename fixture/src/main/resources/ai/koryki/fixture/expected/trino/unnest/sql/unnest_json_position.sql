-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, b.ordinal
, b.value
FROM
 check_complex t
  CROSS JOIN UNNEST(CAST(json_extract(t.doc, '$.a.b') AS ARRAY(INTEGER))) WITH ORDINALITY AS b(value, ordinal)