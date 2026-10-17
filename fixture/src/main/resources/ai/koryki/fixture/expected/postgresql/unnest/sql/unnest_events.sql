-- A struct list with temporal fields: the fields keep their types.
SELECT
  t.nr
, e.day
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.events) AS e(ts, day) ON TRUE