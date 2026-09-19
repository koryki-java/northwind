-- intentionally ignored in dialects not supporting required INTERVALs
SELECT
  c.interval_day_second AS interval_day_second
FROM
 check_temporal c
WHERE
  c.interval_day_second > NUMTODSINTERVAL(1, 'HOUR') + NUMTODSINTERVAL(2, 'MINUTE') + NUMTODSINTERVAL(3, 'SECOND')