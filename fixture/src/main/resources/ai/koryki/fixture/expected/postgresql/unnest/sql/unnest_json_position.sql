-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, b.ordinal
, b.value
FROM
 check_complex t
  INNER JOIN LATERAL unnest(CASE WHEN jsonb_typeof((t.doc -> 'a' -> 'b')) = 'array' THEN ARRAY(SELECT CAST(e.v AS INTEGER) FROM jsonb_array_elements_text((t.doc -> 'a' -> 'b')) WITH ORDINALITY AS e(v, i) ORDER BY e.i) END) WITH ORDINALITY AS b(value, ordinal) ON TRUE