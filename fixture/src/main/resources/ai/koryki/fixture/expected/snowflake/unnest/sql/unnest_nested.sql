-- The list of an element is read from the rows of the earlier unnest.
SELECT
  t.nr
, i.VALUE:sku::VARCHAR
, o.VALUE::VARCHAR
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items) i
    , LATERAL FLATTEN(INPUT => i.VALUE:opts::ARRAY) o