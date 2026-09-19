-- ln: natural logarithm.
SELECT
  o.order_id
, round(LOG(100), 6) AS natural_log
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY