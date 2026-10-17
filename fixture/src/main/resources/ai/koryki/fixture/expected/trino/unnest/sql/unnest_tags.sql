-- A list of scalars: the one column is value. Snowflake FLATTEN leaves a NULL element out.
SELECT
  t.nr
, g.value
FROM
 check_complex t
  CROSS JOIN UNNEST(t.tags) AS g(value)