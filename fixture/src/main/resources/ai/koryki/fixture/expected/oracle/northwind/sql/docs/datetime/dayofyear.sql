-- dayofyear: how far into the year the order date is.
SELECT
  o.order_id
, TO_NUMBER(TO_CHAR(o.order_date, 'DDD')) AS order_dayofyear
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY