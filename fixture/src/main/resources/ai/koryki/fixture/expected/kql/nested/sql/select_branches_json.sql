-- The branches of a row, as a JSON array of objects: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches asks
-- the same of the same data and must give the same rows.
-- (Oracle reads a JSON number as text and casts it, which fails on a session whose decimal separator is
-- a comma - ORA-01722 on "53.54" - so its answer is not asked for; select_branches_json_forward asks
-- Oracle what it can. Its SQL is still checked.)
SELECT
  t.nr
, (t.branches_json ->> '$[0].city') AS first_city
, (t.branches_json ->> '$[#-1].city') AS last_city
, CAST((t.branches_json ->> '$[0].geo.lat') AS DOUBLE) AS first_lat
, (t.branches_json ->> '$[1].zip') AS second_zip
, (t.branches_json ->> '$[3].city') AS fourth_city
FROM
 check_complex t