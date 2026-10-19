-- The branches of a row, as a JSON array of objects: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[0].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[0].city') END AS first_city
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[last].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[last].city') END AS last_city
, CAST(CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[0].type()') = 'object' AND JSON_VALUE(t.branches_json, '$[0].geo.type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[0].geo.lat' RETURNING NUMBER) END AS BINARY_DOUBLE) AS first_lat
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[1].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[1].zip') END AS second_zip
, CASE WHEN JSON_VALUE(t.branches_json, '$.type()') = 'array' AND JSON_VALUE(t.branches_json, '$[3].type()') = 'object' THEN JSON_VALUE(t.branches_json, '$[3].city') END AS fourth_city
FROM
 check_complex t