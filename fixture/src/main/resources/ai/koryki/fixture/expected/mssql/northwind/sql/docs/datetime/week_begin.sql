-- week_begin: Monday of the order's week — the sortable weekly grouping key.
SELECT
  o.order_id
, DATEADD(day, -(DATEDIFF(day, 0, o.order_date) % 7), CAST(o.order_date AS DATE)) AS week_start
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY