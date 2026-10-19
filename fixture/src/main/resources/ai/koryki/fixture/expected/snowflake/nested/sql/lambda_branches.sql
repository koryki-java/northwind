-- A lambda over the elements of a native list of structs: the size of the list, and the city of every branch.
SELECT
  t.nr
, ARRAY_SIZE(t.branches) AS branches
, TRANSFORM(t.branches, _l0_b -> GET(_l0_b, 'city')) AS cities
FROM
 check_complex t