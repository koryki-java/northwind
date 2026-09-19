-- make_time: build a TIME from hour, minute and second.
SELECT
  o.order_id
, TIMEFROMPARTS(14, 30, 0, 0, 0) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY