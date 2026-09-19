-- make_time: build a TIME from hour, minute and second.
SELECT
  o.order_id
, MAKETIME(14, 30, 0) AS built
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY