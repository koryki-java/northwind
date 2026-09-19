-- ln: natural logarithm.
SELECT
  o.order_id
, round(CAST(ln(100) AS numeric), 6) AS natural_log
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY