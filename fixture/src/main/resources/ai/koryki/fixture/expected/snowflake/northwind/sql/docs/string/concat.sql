-- concat: join first and last name.
SELECT
  ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(e.first_name, ' ', e.last_name), '') AS full_name
FROM
 employees e