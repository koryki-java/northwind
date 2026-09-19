-- to_boolean: zero is false, non-zero is true.
SELECT
  (c.type_integer <> 0) AS flag
FROM
 check_type c