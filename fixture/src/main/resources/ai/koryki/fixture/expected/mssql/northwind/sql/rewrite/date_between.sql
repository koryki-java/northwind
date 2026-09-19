-- DATE upper: rewritten to >= lower AND < upper+1d
SELECT
  o.order_id
, o.order_date
FROM
 orders o
WHERE
  o.order_date >= CAST('2022-01-01' AS DATE)
 AND
  o.order_date < CAST('2023-01-01' AS DATE)