-- A list of structs made into rows: one row for each element, with its fields as columns.
SELECT
  t.nr
, i.VALUE:sku::VARCHAR
, i.VALUE:qty::INTEGER * i.VALUE:price::NUMBER(10, 2) AS total
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => t.items) i