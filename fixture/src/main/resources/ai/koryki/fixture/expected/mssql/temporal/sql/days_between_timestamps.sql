-- days_between over TIMESTAMPS means COMPLETE days inside the interval — 24-hour periods, not
-- midnights crossed. Two hours spanning midnight is zero days, not one.
-- The two readings coincide for dates and part company for timestamps, which is why this went
-- unnoticed: MariaDB (TIMESTAMPDIFF) and Oracle (TRUNC of a date difference) counted whole days,
-- while DuckDB, PostgreSQL, SQL Server, Snowflake and SQLite counted boundary crossings.
SELECT
  (DATEDIFF_BIG(second, CAST('2023-01-01T23:00:00' AS DATETIME2), CAST('2023-01-02T01:00:00' AS DATETIME2)) / 86400) AS two_hours_over_midnight
, (DATEDIFF_BIG(second, CAST('2023-01-01T01:00:00' AS DATETIME2), CAST('2023-01-02T23:00:00' AS DATETIME2)) / 86400) AS fortysix_hours
, (DATEDIFF_BIG(second, CAST('2023-01-01T00:00:00' AS DATETIME2), CAST('2023-01-03T00:00:00' AS DATETIME2)) / 86400) AS exactly_two_days
, (DATEDIFF_BIG(second, CAST('2023-01-02T01:00:00' AS DATETIME2), CAST('2023-01-01T23:00:00' AS DATETIME2)) / 86400) AS backwards_two_hours
FROM
 check_temporal c