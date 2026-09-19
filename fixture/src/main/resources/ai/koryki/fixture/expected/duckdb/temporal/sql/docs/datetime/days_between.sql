-- days_between: signed day distance between two dates.
SELECT
  CAST(trunc(date_diff('second', DATE '2023-03-01', DATE '2023-02-01') / 86400.0) AS INTEGER) AS signed_minus28
FROM
 check_temporal c