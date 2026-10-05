-- list(a, b, ...) makes a list out of values, in the order they are written: it is a list like any
-- other, so it is sorted, counted and searched.
SELECT
  t.nr
, list_sort(list_value(3, 1, 2), 'ASC', 'NULLS LAST') AS sorted_literal
, len(list_value(1, 2, 3)) AS n_literal
, list_contains(list_value('red', 'x'), 'red') AS has_red
FROM
 check_complex t