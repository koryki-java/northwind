-- year_end: last day of the order's year.
SELECT
  o.order_id
, DATEFROMPARTS(YEAR(o.order_date), 12, 31) AS y_end
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY