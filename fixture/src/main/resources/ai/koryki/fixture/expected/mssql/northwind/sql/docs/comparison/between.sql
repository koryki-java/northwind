-- BETWEEN : orders in a date range — a temporal upper bound renders as a half-open interval.
SELECT
  o.order_id
, o.order_date
FROM
 orders o
WHERE
  o.order_date >= CAST('2022-07-01' AS DATE)
 AND
  o.order_date < CAST('2023-01-01' AS DATE)
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY