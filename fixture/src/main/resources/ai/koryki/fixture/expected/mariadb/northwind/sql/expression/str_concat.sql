SELECT
  concat_ws('', e.first_name, ' ', e.last_name) AS full_name
, concat_ws('', e.title_of_courtesy, ' ', e.last_name) AS formal
FROM
 employees e
WHERE
  e.employee_id = 1