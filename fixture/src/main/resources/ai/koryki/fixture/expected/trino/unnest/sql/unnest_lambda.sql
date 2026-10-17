-- The list may be what a lambda made.
SELECT
  t.nr
, s.value
FROM
 check_complex t
  CROSS JOIN UNNEST(filter(t.scores, _l0_x -> _l0_x > 5)) AS s(value)