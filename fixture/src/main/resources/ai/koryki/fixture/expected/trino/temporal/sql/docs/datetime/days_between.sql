-- days_between: signed day distance between two dates.
SELECT
  (date_diff('second', CAST(DATE '2023-03-01' AS TIMESTAMP), CAST(DATE '2023-02-01' AS TIMESTAMP)) / 86400) AS signed_minus28
FROM
 check_temporal c