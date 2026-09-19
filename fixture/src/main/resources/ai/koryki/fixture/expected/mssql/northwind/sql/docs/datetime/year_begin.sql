-- year_begin: first day of the order's year.
SELECT
  o.order_id
, DATEADD(YEAR, DATEDIFF(YEAR, 0, o.order_date), 0) AS y_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY