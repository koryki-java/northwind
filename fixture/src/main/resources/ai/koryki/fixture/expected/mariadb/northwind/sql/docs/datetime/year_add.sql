-- year_add: one year after the order date.
SELECT
  o.order_id
, (o.order_date + INTERVAL (1) YEAR) AS next_year
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY