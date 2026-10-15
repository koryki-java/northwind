-- The list can be anything that is a list, a lambda's result as well as a column. Row 2 has an empty
-- list, row 3 NULL elements among its values: nothing matches, and the sum of what is left is 10.
SELECT
  t.nr
, list_contains(list_transform(t.tags, _l0_x -> upper(_l0_x)), 'RED') AS has_red_upper
, len(list_filter(t.scores, _l0_x -> _l0_x > 5)) AS big
, list_sum(list_transform(t.scores, _l0_x -> _l0_x * 2)) AS doubled_total
FROM
 check_complex t