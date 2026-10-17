-- The position counts the NULL element too, and Snowflake FLATTEN does not have it.
SELECT
  t.nr
, (g.INDEX + 1)
, g.VALUE::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.tags) g