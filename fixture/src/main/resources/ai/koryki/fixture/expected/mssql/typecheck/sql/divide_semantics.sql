-- Division has two things the engines disagree on natively, both normalised here.
-- int_div: 7/2 truncates to 3 on postgresql, mssql, trino and sqlite unless the dividend is cast.
-- by_zero: a zero divisor errors on four engines, is NULL on two and Infinity on duckdb; the
-- NULLIF guard makes it NULL everywhere. dec_div shows the guard is skipped for a literal divisor.
SELECT
  CAST(t.type_integer AS float) / NULLIF(t.type_integer, 0) AS int_div_same
, CAST(7 AS float) / 2 AS int_div
, t.type_decimal / NULLIF(t.type_smallint, 0) AS dec_div
, CAST(t.type_integer AS float) / NULLIF((t.type_integer - t.type_integer), 0) AS by_zero
FROM
 check_type t