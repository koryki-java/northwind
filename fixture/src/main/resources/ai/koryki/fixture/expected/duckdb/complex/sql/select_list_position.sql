-- A position selects one element of a list: @1 the first, @-1 the last. Positions count from 1, as
-- in a list of DuckDB; a position outside the list, and any position of an empty list, is NULL.
SELECT
  t.nr
, t.tags[1] AS first_tag
, t.tags[-1] AS last_tag
, t.tags[5] AS fifth_tag
, t.scores[2] AS second_score
FROM
 check_complex t