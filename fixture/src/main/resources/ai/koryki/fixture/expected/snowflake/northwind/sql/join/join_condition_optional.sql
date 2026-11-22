-- The same condition-relationship as an optional link: employees without a later-hired colleague in
-- their city stay, with no partner. A FILTER on the optional alias belongs in the ON clause.
SELECT
  e.last_name
, count(l.employee_id) AS later_sales_representatives
FROM
 employees e
  LEFT OUTER JOIN employees l ON
   e.city = l.city
  AND
   e.hire_date < l.hire_date
  AND
   l.title = 'Sales Representative'
GROUP BY
  e.last_name
ORDER BY
  e.last_name ASC