-- days_between over TIMESTAMPS means COMPLETE days inside the interval — 24-hour periods, not
-- midnights crossed. Two hours spanning midnight is zero days, not one.
-- The two readings coincide for dates and part company for timestamps, which is why this went
-- unnoticed: MariaDB (TIMESTAMPDIFF) and Oracle (TRUNC of a date difference) counted whole days,
-- while DuckDB, PostgreSQL, SQL Server, Snowflake and SQLite counted boundary crossings.
SELECT
  TRUNC(CAST(TIMESTAMP '2023-01-02 01:00:00' AS DATE) - CAST(TIMESTAMP '2023-01-01 23:00:00' AS DATE)) AS two_hours_over_midnight
, TRUNC(CAST(TIMESTAMP '2023-01-02 23:00:00' AS DATE) - CAST(TIMESTAMP '2023-01-01 01:00:00' AS DATE)) AS fortysix_hours
, TRUNC(CAST(TIMESTAMP '2023-01-03 00:00:00' AS DATE) - CAST(TIMESTAMP '2023-01-01 00:00:00' AS DATE)) AS exactly_two_days
, TRUNC(CAST(TIMESTAMP '2023-01-01 23:00:00' AS DATE) - CAST(TIMESTAMP '2023-01-02 01:00:00' AS DATE)) AS backwards_two_hours
FROM
 check_temporal c