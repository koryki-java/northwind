SELECT
  concat(e.first_name, ' ', e.last_name) AS full_name
, concat(e.title_of_courtesy, ' ', e.last_name) AS formal
FROM
 employees e
WHERE
  e.employee_id = 1