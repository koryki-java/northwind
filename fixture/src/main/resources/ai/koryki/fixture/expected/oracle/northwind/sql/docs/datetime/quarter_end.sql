-- quarter_end: last day of the order's quarter.
SELECT
  o.order_id
, LAST_DAY(ADD_MONTHS(TRUNC(o.order_date, 'Q'), 2)) AS q_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY