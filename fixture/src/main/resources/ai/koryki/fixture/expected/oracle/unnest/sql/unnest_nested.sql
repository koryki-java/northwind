-- The list of an element is read from the rows of the earlier unnest.
SELECT
  t.nr
, i.sku
, o.COLUMN_VALUE
FROM
 check_complex t
  CROSS APPLY TABLE(t.items) i
    CROSS APPLY TABLE(i.opts) o