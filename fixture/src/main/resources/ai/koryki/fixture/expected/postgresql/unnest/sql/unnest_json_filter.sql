-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  INNER JOIN LATERAL unnest(CASE WHEN jsonb_typeof((t.doc -> 'a' -> 'b')) = 'array' THEN ARRAY(SELECT CAST(e.v AS INTEGER) FROM jsonb_array_elements_text((t.doc -> 'a' -> 'b')) WITH ORDINALITY AS e(v, i) ORDER BY e.i) END) AS b(value) ON TRUE
WHERE
  b.value > 5