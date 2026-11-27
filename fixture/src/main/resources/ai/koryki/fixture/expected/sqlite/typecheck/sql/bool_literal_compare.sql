-- TRUE and FALSE against the three ways a boolean is stored: a native BOOLEAN column, one held as
-- 0/1 (BOOLEAN_FROM_INTEGER) and one held as 'Y'/'N' (BOOLEAN_FROM_TEXT). The literal is written
-- the way the column stores it, so the query does not say how a dialect keeps its booleans.
SELECT
  t.nr
, t.type_boolean AS native
, t.bool_from_int AS from_int
, t.bool_from_text AS from_text
FROM
 check_type t
WHERE
  t.bool_from_text = 'Y'
 AND
  t.bool_from_int = 1
 AND
  t.type_boolean = 1