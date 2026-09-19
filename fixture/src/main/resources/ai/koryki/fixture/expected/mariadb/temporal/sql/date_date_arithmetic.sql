-- Naive DATE + duration: a calendar-only duration keeps DATE; a clock component promotes to TIMESTAMP.
SELECT
  c.date_date AS date_date
, c.date_date + INTERVAL '14' MONTH + INTERVAL '1' DAY + INTERVAL '1' HOUR + INTERVAL '30' MINUTE AS plus_1year2month1day90min
FROM
 check_temporal c