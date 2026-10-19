-- One row per branch of a native list of structs, with its position and its fields. Oracle has no
-- position for the elements of a collection, so it refuses this one: unnest_branches_fields asks the
-- same without it.
SELECT
  t.nr
, (b.INDEX + 1)
, b.VALUE:street::VARCHAR
, b.VALUE:city::VARCHAR
, b.VALUE:zip::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.branches) b