-- A selection is a value like any other: it filters, it compares with a literal.
SELECT
  t.nr
, t.tags[1] AS first_tag
FROM
 check_complex t
WHERE
  t.scores[2] > 10
 AND
  t.attrs['color'] = 'red'