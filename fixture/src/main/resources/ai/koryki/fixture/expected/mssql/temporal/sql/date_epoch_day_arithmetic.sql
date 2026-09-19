-- DATE stored as a day-count since 1970 (DATE_FROM_EPOCH_DAY) + duration: arithmetic materializes the
-- epoch-day to a date first, then applies the duration (a clock component promotes to TIMESTAMP).
SELECT
  c.date_epoch_day AS date_epoch_day
, DATEADD(SECOND, -10, DATEADD(MINUTE, -30, DATEADD(HOUR, -1, DATEADD(DAY, -1, CAST(DATEADD(DAY, c.date_epoch_day, CAST('1970-01-01' AS DATE)) AS DATETIME2))))) AS minus_1day90min10seconds
FROM
 check_temporal c