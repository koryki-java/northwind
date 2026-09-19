-- year_end: last day of the order's year.
SELECT
  o.order_id
, LAST_DAY(ADD_MONTHS(TRUNC(o.order_date, 'YYYY'), 11)) AS y_end
FROM
 orders o
ORDER BY
  o.order_id ASC
FETCH FIRST 20 ROWS ONLY