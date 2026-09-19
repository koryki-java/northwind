-- concat_ws: join city and country with a separator.
SELECT
  concat_ws(', ', c.city, c.country) AS location
FROM
 customers c