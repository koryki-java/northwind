-- Naive DATE + duration: a calendar-only duration keeps DATE; a clock component promotes to TIMESTAMP.
SELECT
  c.date_date AS date_date
, (ADD_MONTHS(c.date_date, 14) - GREATEST(EXTRACT(DAY FROM ADD_MONTHS(c.date_date, 14)) - EXTRACT(DAY FROM c.date_date), 0)) + NUMTODSINTERVAL(1, 'DAY') + NUMTODSINTERVAL(1, 'HOUR') + NUMTODSINTERVAL(30, 'MINUTE') AS plus_1year2month1day90min
FROM
 check_temporal c