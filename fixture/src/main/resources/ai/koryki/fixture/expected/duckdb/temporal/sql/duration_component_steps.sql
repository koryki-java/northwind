-- A multi-component duration is two quantities: the calendar part (y q mo) summed into months and
-- applied in one step, then the day-and-clock part. TEMPORAL.md and java.time agree --
-- Period.of(1, 1, 0).toTotalMonths() is 13, so 2024-02-29 + 1y1mo is 2025-03-29, not the
-- 2025-03-28 that applying the year and the month separately would give.
-- MariaDB, SQL Server and Trino have no combined interval literal and chained one addition per
-- unit, which clamped at the intermediate step and answered 2025-03-28. SqlDialect.calendarFolded
-- now folds the calendar units for them.
SELECT
  DATE '2024-02-29' + INTERVAL '1 year 1 month' AS combined_year_and_month
FROM
 check_temporal c
WHERE
  c.nr = 1