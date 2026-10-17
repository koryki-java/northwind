-- The list may be what a lambda made.
SELECT
  t.nr
, s.VALUE::INTEGER
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => FILTER(t.scores, _l0_x -> _l0_x > 5)) s