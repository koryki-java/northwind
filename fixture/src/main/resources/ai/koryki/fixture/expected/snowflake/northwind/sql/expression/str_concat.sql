SELECT
  ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(e.first_name, ' ', e.last_name), '') AS full_name
, ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(e.title_of_courtesy, ' ', e.last_name), '') AS formal
FROM
 employees e
WHERE
  e.employee_id = 1