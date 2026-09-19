-- integer × DURATION → DURATION (component-wise scale). A constant factor × duration literal is folded
-- to a scaled duration literal, so it renders portably (no `n * INTERVAL`) and decodes as an Interval.
-- duckdb-first.
SELECT
  INTERVAL '2' HOUR + INTERVAL '4' MINUTE + INTERVAL '6' SECOND AS twice_clock
, INTERVAL '3' YEAR + INTERVAL '6' MONTH AS thrice_year_month
, c.date_date + INTERVAL '2' DAY AS date_plus_two_days
FROM
 check_temporal c
WHERE
  c.nr = 1