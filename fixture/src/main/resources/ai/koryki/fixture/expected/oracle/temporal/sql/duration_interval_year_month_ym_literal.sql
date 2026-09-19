-- intentionally ignored in dialects not supporting required INTERVALs
SELECT
  c.interval_year_month AS interval_year_month
FROM
 check_temporal c
WHERE
  c.interval_year_month > NUMTOYMINTERVAL(1, 'YEAR') + NUMTOYMINTERVAL(2, 'MONTH')