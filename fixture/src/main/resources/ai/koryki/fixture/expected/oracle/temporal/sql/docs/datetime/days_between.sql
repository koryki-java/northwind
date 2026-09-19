-- days_between: signed day distance between two dates.
SELECT
  TRUNC(CAST(DATE '2023-02-01' AS DATE) - CAST(DATE '2023-03-01' AS DATE)) AS signed_minus28
FROM
 check_temporal c