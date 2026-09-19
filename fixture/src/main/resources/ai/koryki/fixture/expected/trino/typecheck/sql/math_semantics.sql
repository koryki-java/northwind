-- The math behaviours the engines do not agree on natively, all normalised here.
-- log_base: T-SQL's LOG takes (value, base) — the reverse of every other engine — so an
-- unguarded log(2, 8) would be 0.333 there and 3 everywhere else. mod_zero: a zero divisor
-- errors on three engines, is NULL on three, and returns the dividend (7) on Oracle.
-- neg_trunc/neg_floor: truncation goes toward zero, flooring goes down — they differ only
-- on negatives, and the emulated forms (sqlite, mssql) must agree with the native ones.
SELECT
  log(2, 8) AS log_base
, mod(7, NULLIF(2, 0)) AS mod_normal
, mod(t.type_integer, NULLIF(t.type_integer - t.type_integer, 0)) AS mod_zero
, truncate(-1.5) AS neg_trunc
, floor(-1.5) AS neg_floor
, truncate(CAST(-19.99 AS DECIMAL(38,10)), 1) AS neg_trunc_scale
FROM
 check_type t