-- A list of scalars: the one column is value. Snowflake FLATTEN leaves a NULL element out.
SELECT
  t.nr
, g.item
FROM
 check_complex t
  INNER JOIN UNNEST(t.tags) AS g(item) ON TRUE