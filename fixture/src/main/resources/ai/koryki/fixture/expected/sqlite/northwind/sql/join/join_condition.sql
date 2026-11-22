-- A relationship with a condition: same_city_later_hire is not a key but a comparison of columns
-- (start.city = end.city AND start.hire_date < end.hire_date), declared once in the catalog. Each
-- employee with the colleagues of the same city who were hired after them.
SELECT
  e.last_name
, l.last_name AS later_colleague
FROM
 employees e
  INNER JOIN employees l ON
   e.city = l.city
  AND
   e.hire_date < l.hire_date
ORDER BY
  e.last_name ASC
, l.last_name ASC