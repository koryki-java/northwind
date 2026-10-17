-- The position of the element in its list, from 1. Oracle has none for a collection in a lateral join.
SELECT
  t.nr
, (i.INDEX + 1)
, i.VALUE:sku::VARCHAR
, i.VALUE:qty::INTEGER * i.VALUE:price::NUMBER(10, 2) AS total
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items) i