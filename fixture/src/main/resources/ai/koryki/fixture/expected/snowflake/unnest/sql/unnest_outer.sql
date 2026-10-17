-- The outer form keeps the row whose list is empty or NULL, with NULLs for the element.
SELECT
  t.nr
, i.VALUE:sku::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items, OUTER => TRUE) i