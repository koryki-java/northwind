-- list_agg(x) makes a list out of the rows of a group. It leaves NULLs out and promises no order, so what
-- is shown is sorted: the first tags of the rows are red and x (row 2 has no first tag), the second
-- scores 5 and 20 (row 2 has none).
SELECT
  list_sort(list(t.nr) FILTER (WHERE t.nr IS NOT NULL), 'ASC', 'NULLS LAST') AS all_nrs
, list_sort(list(t.tags[1]) FILTER (WHERE t.tags[1] IS NOT NULL), 'ASC', 'NULLS LAST') AS first_tags
, list_sort(list(t.scores[2]) FILTER (WHERE t.scores[2] IS NOT NULL), 'ASC', 'NULLS LAST') AS second_scores
FROM
 check_complex t