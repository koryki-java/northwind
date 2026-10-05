-- x IN list is the membership of a value in a list column: 'red' IN t.tags is list_contains(t.tags, 'red').
-- The value meets the elements, so a number against a list of texts is refused. NOT (...) is the negation.
SELECT
  t.nr
, len(t.tags) AS n
FROM
 check_complex t
WHERE
  list_contains(t.tags, 'red')
 AND
  NOT ((
list_contains(t.scores, 4)
   ))