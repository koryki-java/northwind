-- to_boolean: zero is false, non-zero is true.
SELECT
  CAST(c.type_integer AS BOOLEAN) AS flag
FROM
 check_type c