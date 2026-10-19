-- The branches of a row, as a native list of structs: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches_json asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, (element_at(t.branches, 1)).city AS first_city
, (element_at(t.branches, -1)).city AS last_city
, ((element_at(t.branches, 1)).geo).lat AS first_lat
, (element_at(t.branches, 2)).zip AS second_zip
, (element_at(t.branches, 4)).city AS fourth_city
FROM
 check_complex t