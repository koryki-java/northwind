-- year: the year component of the order date.
SELECT
  o.order_id
, EXTRACT(YEAR FROM o.order_date) AS order_year
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY