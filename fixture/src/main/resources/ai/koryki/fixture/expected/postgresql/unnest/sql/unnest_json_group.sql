-- The elements of the JSON array are rows: a count, a sum and an extreme over them.
SELECT
  count(b.value) AS elements
, sum(b.value) AS total
, max(b.value) AS biggest
FROM
 check_complex t
  INNER JOIN LATERAL unnest(CASE WHEN jsonb_typeof((t.doc -> 'a' -> 'b')) = 'array' THEN ARRAY(SELECT CAST(e.v AS INTEGER) FROM jsonb_array_elements_text((t.doc -> 'a' -> 'b')) WITH ORDINALITY AS e(v, i) ORDER BY e.i) END) AS b(value) ON TRUE