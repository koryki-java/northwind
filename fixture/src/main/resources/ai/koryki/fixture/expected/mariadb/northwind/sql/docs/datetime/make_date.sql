-- make_date: build a DATE from year, month and day.
SELECT
  o.order_id
, STR_TO_DATE(CONCAT(2024, '-', 1, '-', 31), '%Y-%m-%d') AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY