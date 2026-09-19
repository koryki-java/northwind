-- days_between: signed day distance between two dates.
SELECT
  CAST(julianday('2023-02-01') - julianday('2023-03-01') AS INTEGER) AS signed_minus28
FROM
 check_temporal c