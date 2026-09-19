-- Month arithmetic on a month-end date whose target day exists in the target month.
-- TEMPORAL.md clamps only "when the target day does not exist". Oracle's ADD_MONTHS additionally
-- promotes every month-end to the target month's last day, and no fixture touched that case: the
-- only one with a month-end is date_date_arithmetic with 2025-12-31, where clamping and promotion
-- happen to agree.
SELECT
  (ADD_MONTHS(DATE '2022-09-30', 1) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(DATE '2022-09-30', 1)) - EXTRACT(DAY FROM DATE '2022-09-30'), 0)) AS month_add_keeps_day
, (ADD_MONTHS(DATE '2022-09-30', 1) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(DATE '2022-09-30', 1)) - EXTRACT(DAY FROM DATE '2022-09-30'), 0)) AS duration_keeps_day
, (ADD_MONTHS(DATE '2024-02-29', 13) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(DATE '2024-02-29', 13)) - EXTRACT(DAY FROM DATE '2024-02-29'), 0)) AS one_step_thirteen_months
FROM
 check_temporal c
WHERE
  c.nr = 1