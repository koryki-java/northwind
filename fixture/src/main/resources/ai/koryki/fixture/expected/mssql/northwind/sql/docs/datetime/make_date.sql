-- make_date: build a DATE from year, month and day.
SELECT
  o.order_id
, DATEFROMPARTS(2024, 1, 31) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY