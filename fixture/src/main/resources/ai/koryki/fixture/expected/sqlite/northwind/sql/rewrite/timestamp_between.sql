-- TIMESTAMP upper: rewritten to >= lower AND < start of next day
SELECT
  o.order_id
, o.delivered_date
FROM
 orders o
WHERE
  o.delivered_date >= '2022-07-01 00:00'
 AND
  o.delivered_date < '2023-01-01 00:00'