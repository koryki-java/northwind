-- A client without branches stays in the answer when the list is unnested with +, the outer form: row 2
-- has an empty list and comes back once, with empty fields. unnest_branches leaves it out.
SELECT
  t.nr
, b.street
, b.city
FROM
 check_complex t
  LEFT OUTER JOIN UNNEST(t.branches) AS b(street, city, zip, geo) ON TRUE