-- A condition on the rows of an outer unnest of JSON keeps every parent. SQL Server takes none there.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  LEFT OUTER JOIN LATERAL unnest(CASE WHEN jsonb_typeof((t.doc -> 'a' -> 'b')) = 'array' THEN ARRAY(SELECT CAST(e.v AS INTEGER) FROM jsonb_array_elements_text((t.doc -> 'a' -> 'b')) WITH ORDINALITY AS e(v, i) ORDER BY e.i) END) AS b(value) ON b.value > 5