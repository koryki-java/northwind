-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, b.value
FROM
 check_complex t
  CROSS JOIN UNNEST(CAST(json_extract(t.doc, '$.a.b') AS ARRAY(INTEGER))) AS b(value)
WHERE
  b.value > 5