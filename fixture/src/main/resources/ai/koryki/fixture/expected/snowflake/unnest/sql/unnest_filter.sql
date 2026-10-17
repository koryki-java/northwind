-- A filter on the rows of an inner unnest keeps the matching elements.
SELECT
  t.nr
, i.VALUE:sku::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items) i
WHERE
  i.VALUE:qty::INTEGER > 1