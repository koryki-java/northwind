-- A list of scalars: the one column is value. Snowflake FLATTEN leaves a NULL element out.
SELECT
  t.nr
, g.VALUE::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.tags) g