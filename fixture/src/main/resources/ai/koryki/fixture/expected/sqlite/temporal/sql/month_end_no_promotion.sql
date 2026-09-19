-- Month arithmetic on a month-end date whose target day exists in the target month.
-- TEMPORAL.md clamps only "when the target day does not exist". Oracle's ADD_MONTHS additionally
-- promotes every month-end to the target month's last day, and no fixture touched that case: the
-- only one with a month-end is date_date_arithmetic with 2025-12-31, where clamping and promotion
-- happen to agree.
SELECT
  min(date('2022-09-30', printf('%+d months', 1)), date('2022-09-30', 'start of month', printf('%+d months', 1 + 1), '-1 day')) AS month_add_keeps_day
, min(date('2022-09-30', '+1 months'), date('2022-09-30', 'start of month', '+2 months', '-1 day')) AS duration_keeps_day
, min(date('2024-02-29', printf('%+d months', 13)), date('2024-02-29', 'start of month', printf('%+d months', 13 + 1), '-1 day')) AS one_step_thirteen_months
FROM
 check_temporal c
WHERE
  c.nr = 1