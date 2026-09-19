-- week: the ISO-8601 week number of the order date.
SELECT
  o.order_id
, ((CAST(strftime('%j', date(o.order_date, '-3 days', 'weekday 4')) AS INTEGER) - 1) / 7 + 1) AS order_week
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20