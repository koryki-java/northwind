-- A list of scalars: the one column is value. Snowflake FLATTEN leaves a NULL element out.
SELECT
  t.nr
, g.COLUMN_VALUE
FROM
 check_complex t
  CROSS APPLY TABLE(t.tags) g