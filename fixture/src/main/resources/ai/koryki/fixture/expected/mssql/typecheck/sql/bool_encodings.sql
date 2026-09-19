-- The three ways a boolean reaches the database: a native BOOLEAN column, one stored as 0/1
-- (BOOLEAN_FROM_INTEGER) and one stored as 'Y'/'N' (BOOLEAN_FROM_TEXT). All three are conditions
-- on their own, and all three read back as true/false — how a dialect stores it is the schema's
-- business, not the query's.
SELECT
  t.nr
, t.type_boolean AS native
, t.bool_from_int AS from_int
, t.bool_from_text AS from_text
FROM
 check_type t
WHERE
  t.bool_from_text = 'Y'
 AND
  t.bool_from_int <> 0
 AND
  t.type_boolean = 1