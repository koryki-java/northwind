-- The branches of a row, as a native list of structs: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches_json asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, GET(GET(t.branches, 0), 'city') AS first_city
, GET(CASE WHEN ARRAY_SIZE(t.branches) >= 1 THEN GET(t.branches, ARRAY_SIZE(t.branches) - 1) END, 'city') AS last_city
, GET(GET(GET(t.branches, 0), 'geo'), 'lat') AS first_lat
, GET(GET(t.branches, 1), 'zip') AS second_zip
, GET(GET(t.branches, 3), 'city') AS fourth_city
FROM
 check_complex t