-- year_add: one year after the order date.
SELECT
  o.order_id
, DATEADD('year', 1, o.order_date) AS next_year
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY