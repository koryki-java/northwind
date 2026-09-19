-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, CAST(date_trunc('quarter', o.order_date) + INTERVAL '3 months - 1 day' AS DATE) AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY