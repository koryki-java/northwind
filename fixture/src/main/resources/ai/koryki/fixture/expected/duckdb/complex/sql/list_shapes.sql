-- Lists made of lists. NULL elements come last in either order, list_distinct drops them and gives the
-- rest in ascending order, and list_concat is NULL when either list is (vec of row 2 is NULL).
SELECT
  t.nr
, list_sort(t.tags, 'ASC', 'NULLS LAST') AS sorted_tags
, list_sort(t.scores, 'DESC', 'NULLS LAST') AS scores_desc
, list_sort(list_distinct(CASE WHEN t.tags IS NULL AND t.tags IS NULL THEN NULL ELSE list_concat(t.tags, t.tags) END), 'ASC', 'NULLS LAST') AS distinct_tags
, CASE WHEN t.scores IS NULL AND list_transform(t.scores, _l0_x -> _l0_x * 10) IS NULL THEN NULL ELSE list_concat(t.scores, list_transform(t.scores, _l0_x -> _l0_x * 10)) END AS joined
, CASE WHEN t.vec IS NULL AND t.vec IS NULL THEN NULL ELSE list_concat(t.vec, t.vec) END AS vec_twice
FROM
 check_complex t