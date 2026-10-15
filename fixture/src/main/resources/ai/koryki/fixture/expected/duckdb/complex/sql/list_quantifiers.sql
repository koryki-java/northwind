-- Whether some or every element passes a test. An empty list has no element that passes and every
-- element of it does; a test that is NULL does not pass (row 3 has NULL scores and a NULL quantity).
SELECT
  t.nr
, (len(list_filter(t.scores, _l0_x -> _l0_x > 25)) > 0) AS any_big
, (len(list_filter(t.scores, _l0_x -> _l0_x > 5)) = len(t.scores)) AS all_big
, (len(list_filter(t.items, _l0_it -> _l0_it['qty'] > 1)) > 0) AS any_many
, (len(list_filter(t.items, _l0_it -> _l0_it['qty'] > 0)) = len(t.items)) AS all_stocked
FROM
 check_complex t