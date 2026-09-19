-- months_between: whole completed months between two dates.
SELECT
  (DATEDIFF(month, CAST('2023-01-31' AS DATE), CAST('2023-03-31' AS DATE)) - CASE WHEN DAY(CAST('2023-03-31' AS DATE)) < DAY(CAST('2023-01-31' AS DATE)) THEN 1 ELSE 0 END) AS whole_two
FROM
 check_temporal c