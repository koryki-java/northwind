-- months_between: whole completed months between two dates.
SELECT
  TIMESTAMPDIFF(MONTH, DATE '2023-01-31', DATE '2023-03-31') AS whole_two
FROM
 check_temporal c