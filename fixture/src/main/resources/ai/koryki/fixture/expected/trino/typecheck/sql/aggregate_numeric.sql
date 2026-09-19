-- sum, avg, min and max over every numeric width the schema has. The type-check corpus covered no
-- aggregate at all, so the return types the catalog declares — sum and min/max hand back the
-- argument's own type, avg always comes back fractional — were never held against what the engines
-- actually return. Engines widen a sum to avoid overflow, and they do not agree on how far.
SELECT
  sum(c.type_smallint) AS sum_smallint
, sum(c.type_integer) AS sum_integer
, sum(c.type_bigint) AS sum_bigint
, sum(c.type_decimal) AS sum_decimal
, sum(c.type_double) AS sum_double
, avg(CAST(c.type_integer AS DOUBLE)) AS avg_integer
, avg(CAST(c.type_decimal AS DOUBLE)) AS avg_decimal
, min(c.type_decimal) AS min_decimal
, max(c.type_double) AS max_double
FROM
 check_type c