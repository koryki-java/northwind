-- The list may be what a lambda made.
SELECT
  t.nr
, s.value
FROM
 check_complex t
  INNER JOIN LATERAL unnest(CASE WHEN t.scores IS NULL THEN NULL ELSE ARRAY(SELECT _l0_x FROM (SELECT t.scores[_i] AS _l0_x, _i AS _pos__l0_x FROM generate_subscripts(t.scores, 1) AS _i) AS _u WHERE _l0_x > 5 ORDER BY _pos__l0_x) END) AS s(value) ON TRUE