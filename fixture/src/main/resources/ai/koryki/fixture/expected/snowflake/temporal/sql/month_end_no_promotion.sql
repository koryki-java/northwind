-- Month arithmetic on a month-end date whose target day exists in the target month.
-- TEMPORAL.md clamps only "when the target day does not exist". Oracle's ADD_MONTHS additionally
-- promotes every month-end to the target month's last day, and no fixture touched that case: the
-- only one with a month-end is date_date_arithmetic with 2025-12-31, where clamping and promotion
-- happen to agree.
SELECT
  DATEADD('month', 1, DATE '2022-09-30') AS month_add_keeps_day
, DATE '2022-09-30' + INTERVAL '1 month' AS duration_keeps_day
, DATEADD('month', 13, DATE '2024-02-29') AS one_step_thirteen_months
FROM
 check_temporal c
WHERE
  c.nr = 1