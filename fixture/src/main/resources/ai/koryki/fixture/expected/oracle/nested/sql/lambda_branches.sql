-- A lambda over the elements of a native list of structs: the size of the list, and the city of every branch.
SELECT
  t.nr
, CASE WHEN t.branches IS NULL THEN NULL ELSE (SELECT COUNT(*) FROM TABLE(t.branches)) END AS branches
, CASE WHEN t.branches IS NULL THEN NULL ELSE CAST(MULTISET(SELECT LA0.X.city FROM (SELECT VALUE(Z) X, ROWNUM I FROM TABLE(t.branches) Z) LA0 ORDER BY LA0.I) AS SYS.ODCIVARCHAR2LIST) END AS cities
FROM
 check_complex t