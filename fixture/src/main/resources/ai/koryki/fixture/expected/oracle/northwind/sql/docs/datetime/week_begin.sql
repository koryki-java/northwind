-- week_begin: Monday of the order's week — the sortable weekly grouping key.
SELECT
  o.order_id
, TRUNC(o.order_date, 'IW') AS week_start
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY