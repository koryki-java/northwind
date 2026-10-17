-- The list may be what a lambda made.
SELECT
  t.nr
, s.item
FROM
 check_complex t
  INNER JOIN UNNEST(list_filter(t.scores, _l0_x -> _l0_x > 5)) AS s(item) ON TRUE