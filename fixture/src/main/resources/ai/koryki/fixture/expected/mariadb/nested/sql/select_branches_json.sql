-- The branches of a row, as a JSON array of objects: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[0].city'), JSON_VALUE(t.branches_json, '$[0].city')) END AS first_city
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[last]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[last].city'), JSON_VALUE(t.branches_json, '$[last].city')) END AS last_city
, CAST(CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0]')) = 'OBJECT' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[0].geo')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[0].geo.lat'), JSON_VALUE(t.branches_json, '$[0].geo.lat')) END AS DOUBLE) AS first_lat
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[1]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[1].zip'), JSON_VALUE(t.branches_json, '$[1].zip')) END AS second_zip
, CASE WHEN JSON_TYPE(JSON_QUERY(t.branches_json, '$')) = 'ARRAY' AND JSON_TYPE(JSON_QUERY(t.branches_json, '$[3]')) = 'OBJECT' THEN COALESCE(JSON_QUERY(t.branches_json, '$[3].city'), JSON_VALUE(t.branches_json, '$[3].city')) END AS fourth_city
FROM
 check_complex t