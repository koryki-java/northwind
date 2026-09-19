-- week_begin: Monday of the order's week — the sortable weekly grouping key.
SELECT
  o.order_id
, (DATE(o.order_date) - INTERVAL WEEKDAY(o.order_date) DAY) AS week_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY