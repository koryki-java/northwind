-- dayofyear: how far into the year the order date is.
SELECT
  o.order_id
, CAST(strftime('%j', o.order_date) AS INTEGER) AS order_dayofyear
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20