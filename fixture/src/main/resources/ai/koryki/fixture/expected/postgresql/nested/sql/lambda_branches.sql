-- A lambda over the elements of a native list of structs: the size of the list, and the city of every branch.
SELECT
  t.nr
, cardinality(t.branches) AS branches
, CASE WHEN t.branches IS NULL THEN NULL ELSE ARRAY(SELECT (_l0_b).city FROM (SELECT t.branches[_i] AS _l0_b, _i AS _pos__l0_b FROM generate_subscripts(t.branches, 1) AS _i) AS _u ORDER BY _pos__l0_b) END AS cities
FROM
 check_complex t