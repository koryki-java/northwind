-- dayofyear: how far into the year the order date is.
SELECT
  o.order_id
, DATEPART(dayofyear, o.order_date) AS order_dayofyear
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY