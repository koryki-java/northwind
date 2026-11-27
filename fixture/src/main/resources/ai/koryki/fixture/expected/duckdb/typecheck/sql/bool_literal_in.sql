-- A boolean literal inside an IN list takes the encoding of the column on its left.
SELECT
  t.nr
FROM
 check_type t
WHERE
  t.bool_from_text IN ('Y', 'N')
 AND
  t.bool_from_int IN (1)