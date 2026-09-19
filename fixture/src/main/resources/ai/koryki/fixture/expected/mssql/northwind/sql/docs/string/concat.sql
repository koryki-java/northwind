-- concat: join first and last name.
SELECT
  concat(e.first_name, ' ', e.last_name) AS full_name
FROM
 employees e