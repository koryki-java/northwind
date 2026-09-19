-- quarter_begin: first day of the order's quarter.
SELECT
  o.order_id
, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, o.order_date), 0) AS q_begin
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY