-- days_between: signed day distance between two dates.
SELECT
  CAST(trunc(EXTRACT(EPOCH FROM (CAST(DATE '2023-02-01' AS timestamp) - CAST(DATE '2023-03-01' AS timestamp))) / 86400.0) AS INTEGER) AS signed_minus28
FROM
 check_temporal c