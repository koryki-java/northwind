-- dayofyear: how far into the year the order date is.
SELECT
  o.order_id
, EXTRACT(DOY FROM o.order_date) AS order_dayofyear
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY