-- months_between: whole completed months between two dates.
SELECT
  (DATEDIFF(month, DATE '2023-01-31', DATE '2023-03-31') - CASE WHEN DAY(DATE '2023-03-31') < DAY(DATE '2023-01-31') THEN 1 ELSE 0 END) AS whole_two
FROM
 check_temporal c