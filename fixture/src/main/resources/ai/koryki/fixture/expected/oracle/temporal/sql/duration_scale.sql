-- integer × DURATION → DURATION (component-wise scale). A constant factor × duration literal is folded
-- to a scaled duration literal, so it renders portably (no `n * INTERVAL`) and decodes as an Interval.
-- duckdb-first.
SELECT
  NUMTODSINTERVAL(2, 'HOUR') + NUMTODSINTERVAL(4, 'MINUTE') + NUMTODSINTERVAL(6, 'SECOND') AS twice_clock
, NUMTOYMINTERVAL(3, 'YEAR') + NUMTOYMINTERVAL(6, 'MONTH') AS thrice_year_month
, c.date_date + NUMTODSINTERVAL(2, 'DAY') AS date_plus_two_days
FROM
 check_temporal c
WHERE
  c.nr = 1