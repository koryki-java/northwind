-- concat_ws: join city and country with a separator.
SELECT
  ARRAY_TO_STRING(ARRAY_CONSTRUCT_COMPACT(c.city, c.country), ', ') AS location
FROM
 customers c