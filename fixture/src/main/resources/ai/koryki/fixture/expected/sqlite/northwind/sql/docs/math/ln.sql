-- ln: natural logarithm.
SELECT
  o.order_id
, round(ln(100), 6) AS natural_log
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20