-- year: the year component of the order date.
SELECT
  o.order_id
, CAST(strftime('%Y', o.order_date) AS INTEGER) AS order_year
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20