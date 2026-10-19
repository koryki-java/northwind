-- The branches of a row, as a native list of structs: an element by position from the start and from the end,
-- a field of it, a field of a struct inside it, and a position that is not there. select_branches_json asks
-- the same of the same data and must give the same rows.
SELECT
  t.nr
, (SELECT E1.V.city FROM (SELECT VALUE(Z) V, ROWNUM RN FROM TABLE(t.branches) Z) E1 WHERE E1.RN = 1 AND t.branches IS NOT NULL) AS first_city
, (SELECT E1.V.city FROM (SELECT VALUE(Z) V, ROWNUM RN FROM TABLE(t.branches) Z) E1 WHERE E1.RN = (SELECT COUNT(*) FROM TABLE(t.branches)) - 1 + 1 AND t.branches IS NOT NULL) AS last_city
, (SELECT E1.V.geo.lat FROM (SELECT VALUE(Z) V, ROWNUM RN FROM TABLE(t.branches) Z) E1 WHERE E1.RN = 1 AND t.branches IS NOT NULL) AS first_lat
, (SELECT E1.V.zip FROM (SELECT VALUE(Z) V, ROWNUM RN FROM TABLE(t.branches) Z) E1 WHERE E1.RN = 2 AND t.branches IS NOT NULL) AS second_zip
, (SELECT E1.V.city FROM (SELECT VALUE(Z) V, ROWNUM RN FROM TABLE(t.branches) Z) E1 WHERE E1.RN = 4 AND t.branches IS NOT NULL) AS fourth_city
FROM
 check_complex t