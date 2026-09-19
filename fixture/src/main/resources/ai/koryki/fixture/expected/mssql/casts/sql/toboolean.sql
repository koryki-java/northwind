-- to_boolean converts a number to a yes/no value: 0 is false, anything else is true.
-- units_in_stock rather than discontinued — the latter is now declared BOOLEAN_FROM_INTEGER, so it
-- is already a yes/no value and needs no conversion.
SELECT
  p.product_name
, CAST(p.units_in_stock AS BIT) AS has_stock
FROM
 products p