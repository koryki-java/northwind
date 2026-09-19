-- make_date: build a DATE from year, month and day.
SELECT
  o.order_id
, DATE_FROM_PARTS(2024, 1, 31) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY