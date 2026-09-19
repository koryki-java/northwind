-- to_bigint: to a 64-bit integer.
SELECT
  CAST(c.type_integer AS NUMBER(19)) AS as_bigint
FROM
 check_type c