-- week: the ISO-8601 week number of the order date.
SELECT
  o.order_id
, DATEPART(iso_week, o.order_date) AS order_week
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY