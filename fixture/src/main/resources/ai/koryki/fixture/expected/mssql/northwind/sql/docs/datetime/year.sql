-- year: the year component of the order date.
SELECT
  o.order_id
, year(o.order_date) AS order_year
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY