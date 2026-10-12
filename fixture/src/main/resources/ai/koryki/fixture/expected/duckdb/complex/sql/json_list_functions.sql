-- A JSON array whose elements the catalog declares (.a.b[] INTEGER) is a list: the list functions
-- and lambdas apply to it. Row 1 holds [5, 6]; the others have no such array.
SELECT
  t.nr
, len(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS size
, list_sum(CAST((t.doc -> '$.a.b') AS INTEGER[])) AS total
, list_contains(CAST((t.doc -> '$.a.b') AS INTEGER[]), 6) AS has_six
FROM
 check_complex t