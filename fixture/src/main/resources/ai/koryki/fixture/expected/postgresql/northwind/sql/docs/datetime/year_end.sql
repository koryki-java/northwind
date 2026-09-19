-- year_end: last day of the order's year.
SELECT
  o.order_id
, CAST(date_trunc('year', o.order_date) + INTERVAL '1 year - 1 day' AS DATE) AS y_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY