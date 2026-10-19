-- One row per branch of a native list of structs, with its fields and a field of the struct inside.
-- A branch without a position has an empty latitude, not a JSON null.
SELECT
  t.nr
, b.street
, b.city
, b.zip
, (b.geo).lat AS latitude
FROM
 check_complex t
  CROSS JOIN UNNEST(t.branches) AS b(street, city, zip, geo)