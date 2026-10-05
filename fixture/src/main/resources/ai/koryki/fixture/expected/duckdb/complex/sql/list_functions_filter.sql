-- The functions work where a condition is: the rows whose list holds a value, and the rows with
-- something in the list at all.
SELECT
  t.nr
, len(t.scores) AS n
FROM
 check_complex t
WHERE
   list_contains(t.tags, 'red')
  OR
   len(t.scores) > 2