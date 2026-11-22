-- Explicit join columns in EXISTS are the correlation. employees has a relationship to itself
-- (reports_to), and the columns written here are another one: the city. An EXISTS that ignored the
-- columns and looked the relationship up would answer "who reports to a Sales Manager" instead of
-- "who works in a city with a Sales Manager" (the manager in London reports to nobody there).
SELECT
  e.employee_id
, e.last_name
FROM
 employees e
WHERE
  
  EXISTS (
   SELECT
    1
  FROM
   employees c
  WHERE
   e.city = c.city
  AND
    c.title = 'Sales Manager'
  )