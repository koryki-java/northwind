-- week: the ISO-8601 week number of the order date.
SELECT
  o.order_id
, TO_NUMBER(TO_CHAR(o.order_date, 'IW')) AS order_week
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY