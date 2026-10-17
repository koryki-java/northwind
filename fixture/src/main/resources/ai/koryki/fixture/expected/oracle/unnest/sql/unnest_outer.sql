-- The outer form keeps the row whose list is empty or NULL, with NULLs for the element.
SELECT
  t.nr
, i.sku
FROM
 check_complex t
  OUTER APPLY TABLE(t.items) i