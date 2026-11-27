-- A boolean literal is a condition on its own. Engines without a boolean value say it as a
-- comparison (1 = 1); the rest write the keyword.
SELECT
  t.nr
FROM
 check_type t
WHERE
  TRUE
 AND
  NOT (FALSE)