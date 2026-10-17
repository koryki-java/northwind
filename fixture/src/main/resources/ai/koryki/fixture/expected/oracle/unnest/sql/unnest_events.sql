-- A struct list with temporal fields: the fields keep their types.
SELECT
  t.nr
, e.day
FROM
 check_complex t
  CROSS APPLY TABLE(t.events) e