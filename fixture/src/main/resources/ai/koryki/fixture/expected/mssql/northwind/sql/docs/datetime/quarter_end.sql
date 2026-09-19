-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, EOMONTH(DATEADD(QUARTER, DATEDIFF(QUARTER, 0, o.order_date), 0), 2) AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY