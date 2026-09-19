-- year_add: one year after the order date.
SELECT
  o.order_id
, DATEADD(YEAR, 1, o.order_date) AS next_year
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY