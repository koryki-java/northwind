-- to_smallint: to a 16-bit integer.
SELECT
  CAST(c.type_smallint AS SIGNED) AS as_smallint
FROM
 check_type c