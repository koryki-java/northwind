-- Month arithmetic on a month-end date whose target day exists in the target month.
-- TEMPORAL.md clamps only "when the target day does not exist". Oracle's ADD_MONTHS additionally
-- promotes every month-end to the target month's last day, and no fixture touched that case: the
-- only one with a month-end is date_date_arithmetic with 2025-12-31, where clamping and promotion
-- happen to agree.
SELECT
  DATEADD(MONTH, 1, CAST('2022-09-30' AS DATE)) AS month_add_keeps_day
, DATEADD(MONTH, 1, CAST('2022-09-30' AS DATE)) AS duration_keeps_day
, DATEADD(MONTH, 13, CAST('2024-02-29' AS DATE)) AS one_step_thirteen_months
FROM
 check_temporal c
WHERE
  c.nr = 1