-- week_begin: Monday of the order's week — the sortable weekly grouping key.
SELECT
  o.order_id
, date(o.order_date, '-6 days', 'weekday 1') AS week_start
FROM
 orders o
ORDER BY
  o.order_id ASC
LIMIT 20