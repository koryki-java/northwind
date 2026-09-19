-- week_begin: Monday of the order's week — the sortable weekly grouping key.
SELECT
  o.order_id
, date_trunc('week', o.order_date) AS week_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY