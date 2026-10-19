-- The branches of a row, as a native list of structs: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches_json asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, (t.branches[1]).city AS first_city
, (t.branches[array_length(t.branches, 1)]).city AS last_city
, ((t.branches[1]).geo).lat AS first_lat
, (t.branches[2]).zip AS second_zip
, (t.branches[4]).city AS fourth_city
FROM
 check_complex t