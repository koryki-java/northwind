-- One row per branch of a native list of structs, with its fields and a field of the struct inside.
-- A branch without a position has an empty latitude, not a JSON null.
SELECT
  t.nr
, b.VALUE:street::VARCHAR
, b.VALUE:city::VARCHAR
, b.VALUE:zip::VARCHAR
, GET(b.VALUE:geo::OBJECT(lat DOUBLE, lon DOUBLE), 'lat') AS latitude
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.branches) b