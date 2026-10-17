-- A struct list with temporal fields: the fields keep their types.
SELECT
  t.nr
, e.item['day']
FROM
 check_complex t
  INNER JOIN UNNEST(t.events) AS e(item) ON TRUE