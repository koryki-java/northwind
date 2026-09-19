-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, LAST_DAY(o.order_date, 'quarter') AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY