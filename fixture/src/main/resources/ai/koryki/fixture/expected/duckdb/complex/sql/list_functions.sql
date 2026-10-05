-- What a list answers about itself. The size counts NULL elements and is NULL for a list that is NULL
-- (vec in row 2); the aggregates ignore NULL elements and are NULL when nothing is left (row 2 has an
-- empty list, row 3 has two NULLs and a 5); a list that is there either holds the value or it does not.
SELECT
  t.nr
, len(t.tags) AS tags
, len(t.vec) AS vec
, list_contains(t.tags, 'red') AS has_red
, list_sum(t.scores) AS total
, list_min(t.scores) AS lowest
, list_max(t.scores) AS highest
, list_avg(t.scores) AS average
FROM
 check_complex t