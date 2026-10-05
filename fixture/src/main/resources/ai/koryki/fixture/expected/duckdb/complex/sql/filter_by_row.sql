-- A nested column fetched next to a scalar filter: the filter on the key does not care what the
-- other columns hold.
SELECT
  t.nr
, t.tags
, t.items
FROM
 check_complex t
WHERE
  t.nr = 3