-- The position counts the NULL element too, and Snowflake FLATTEN does not have it.
SELECT
  t.nr
, g.ordinal
, g.value
FROM
 check_complex t
  INNER JOIN LATERAL unnest(t.tags) WITH ORDINALITY AS g(value, ordinal) ON TRUE