-- The same for a fold, which has two parameters: where the dialect has one.
SELECT
  t.nr
, list_reduce(t.scores, (_l0_order, _l0_case) -> _l0_order + _l0_case) AS total
FROM
 check_complex t
WHERE
  t.nr <> 2