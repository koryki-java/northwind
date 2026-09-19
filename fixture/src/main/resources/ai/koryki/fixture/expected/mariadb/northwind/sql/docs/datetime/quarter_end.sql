-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, LAST_DAY(MAKEDATE(YEAR(o.order_date), 1) + INTERVAL (QUARTER(o.order_date) * 3 - 1) MONTH) AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY