-- Naive DATE + duration: a calendar-only duration keeps DATE; a clock component promotes to TIMESTAMP.
SELECT
  c.date_date AS date_date
, datetime(min(datetime(c.date_date, '+14 months'), datetime(c.date_date, 'start of month', '+15 months', '-1 day')), '+1 days', '+1 hours', '+30 minutes') AS plus_1year2month1day90min
FROM
 check_temporal c