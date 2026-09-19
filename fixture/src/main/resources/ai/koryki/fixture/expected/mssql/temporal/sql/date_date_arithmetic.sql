-- Naive DATE + duration: a calendar-only duration keeps DATE; a clock component promotes to TIMESTAMP.
SELECT
  c.date_date AS date_date
, DATEADD(MINUTE, 30, DATEADD(HOUR, 1, DATEADD(DAY, 1, DATEADD(MONTH, 14, CAST(c.date_date AS DATETIME2))))) AS plus_1year2month1day90min
FROM
 check_temporal c