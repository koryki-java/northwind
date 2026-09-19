-- make_date: build a DATE from year, month and day.
SELECT
  o.order_id
, date(printf('%04d-%02d-%02d', 2024, 1, 31)) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20