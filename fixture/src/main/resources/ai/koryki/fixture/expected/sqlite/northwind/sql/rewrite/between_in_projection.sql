-- The same BETWEEN must mean the same range wherever it stands. The half-open rewrite used to visit
-- only filter and having, so a condition reaching the projection through case(...) stayed inclusive
-- while the identical condition in a FILTER was widened to cover the whole day — see the sibling
-- fixture timestamp_between, which renders exactly this bound as >= lower AND < 2023-01-01 00:00:00.
SELECT
  o.order_id
, CASE WHEN (o.delivered_date >= '2022-07-01 00:00' AND o.delivered_date < '2023-01-01 00:00') THEN 'in' ELSE 'out' END AS second_half_2022
FROM
 orders o
WHERE
  o.order_id < 10253
ORDER BY
  o.order_id ASC