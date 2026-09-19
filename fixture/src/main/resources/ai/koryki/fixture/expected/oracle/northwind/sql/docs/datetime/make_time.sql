-- make_time: build a TIME from hour, minute and second.
SELECT
  o.order_id
, LPAD(14, 2, '0') || ':' || LPAD(30, 2, '0') || ':' || LPAD(0, 2, '0') AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY