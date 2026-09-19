-- A boolean column standing alone as a filter condition. bool_from_int is BOOLEAN_FROM_INTEGER,
-- physically 0/1, so the predicate is derived from the encoding rather than passed through bare —
-- which is what makes this work on engines that have no boolean type to put in a WHERE clause.
SELECT
  c.nr
, c.bool_from_int
FROM
 check_temporal c
WHERE
  c.bool_from_int <> 0