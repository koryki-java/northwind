-- TIMESTAMP upper: rewritten to >= lower AND < start of next day
SELECT
  o.order_id
, o.delivered_date
FROM
 orders o
WHERE
  o.delivered_date >= CAST('2022-07-01T00:00:00' AS DATETIME2)
 AND
  o.delivered_date < CAST('2023-01-01T00:00:00' AS DATETIME2)