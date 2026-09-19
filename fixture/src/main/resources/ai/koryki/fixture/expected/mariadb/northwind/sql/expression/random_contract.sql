-- random() promises two things — a value in [0.0, 1.0) and a fresh draw per row — and neither was
-- checked anywhere: its doc sample is ignored on all eight dialects, so no golden ever compared it.
-- The CSV that sat next to it claimed 0.0 for every row.
-- Measured, the function did not exist at all on MariaDB, Oracle and SQL Server, and returned a
-- signed 64-bit integer on SQLite. The per-row half is the subtler one: SQL Server's RAND() is
-- seeded once per statement and hands every row the SAME number, which is not a random column.
SELECT
  CASE WHEN COUNT(DISTINCT RAND()) > 1 THEN 'yes' ELSE 'no' END AS varies_per_row
, CASE WHEN min(RAND()) >= 0 THEN 'yes' ELSE 'no' END AS never_negative
, CASE WHEN max(RAND()) < 1 THEN 'yes' ELSE 'no' END AS never_reaches_one
FROM
 orders o