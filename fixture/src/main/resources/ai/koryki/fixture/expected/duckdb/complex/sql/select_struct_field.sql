-- A name selects a struct field, a position the field at that place. @'...' takes a field whose
-- name needs quoting, and finds it regardless of case, as DuckDB does.
SELECT
  t.nr
, t.dims['w'] AS width
, t.dims['h'] AS height
, struct_extract_at(t.dims, 1) AS first_field
, struct_extract_at(t.dims, 2) AS last_field
, t.address['street'] AS street
, t.address['geo']['lat'] AS latitude
, t.address['phones'][1] AS first_phone
, t.odd['Odd Name'] AS odd_name
, t.odd['ODD NAME'] AS odd_name_upper
, t.odd['x'] AS odd_x
FROM
 check_complex t