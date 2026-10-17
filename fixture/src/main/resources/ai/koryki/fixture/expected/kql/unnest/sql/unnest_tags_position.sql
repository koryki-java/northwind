-- The position counts the NULL element too, and Snowflake FLATTEN does not have it.
SELECT
  t.nr
, g.ordinal
, g.item
FROM
 check_complex t
  INNER JOIN UNNEST(t.tags) WITH ORDINALITY AS g(item, ordinal) ON TRUE