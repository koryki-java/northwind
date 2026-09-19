-- week: the ISO-8601 week number of the order date.
SELECT
  o.order_id
, week(o.order_date) AS order_week
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY