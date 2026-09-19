-- BETWEEN : orders in a date range — a temporal upper bound renders as a half-open interval.
SELECT
  o.order_id
, o.order_date
FROM
 orders o
WHERE
  o.order_date >= '2022-07-01'
 AND
  o.order_date < '2023-01-01'
ORDER BY
  o.order_id ASC
LIMIT 20