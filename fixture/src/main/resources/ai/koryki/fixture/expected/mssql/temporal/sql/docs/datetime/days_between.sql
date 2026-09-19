-- days_between: signed day distance between two dates.
SELECT
  (DATEDIFF_BIG(second, CAST('2023-03-01' AS DATE), CAST('2023-02-01' AS DATE)) / 86400) AS signed_minus28
FROM
 check_temporal c