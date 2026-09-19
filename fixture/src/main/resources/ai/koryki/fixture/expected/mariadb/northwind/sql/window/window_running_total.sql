-- Running total: cumulative freight per employee, ordered by date.
-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW accumulates all rows
-- from the start of the employee's partition up to the current row.
SELECT
  e.employee_id
, o.order_date
, o.order_id
, o.freight
, sum(o.freight) OVER (PARTITION BY e.employee_id ORDER BY o.order_date, o.order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_freight
FROM
 orders o
  INNER JOIN employees e ON
   o.employee_id = e.employee_id
WHERE
  e.employee_id < 4
ORDER BY
  e.employee_id ASC
, o.order_date ASC
, o.order_id ASC