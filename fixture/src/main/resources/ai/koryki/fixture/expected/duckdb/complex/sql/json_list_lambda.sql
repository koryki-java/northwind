-- A lambda over a JSON array: its elements are the declared integers.
SELECT
  t.nr
, list_transform(CAST((t.doc -> '$.a.b') AS INTEGER[]), _l0_x -> _l0_x * 10) AS tenfold
, list_filter(CAST((t.doc -> '$.a.b') AS INTEGER[]), _l0_x -> _l0_x > 5) AS big
FROM
 check_complex t
WHERE
  len(CAST((t.doc -> '$.a.b') AS INTEGER[])) > 0