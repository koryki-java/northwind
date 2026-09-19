-- The calendar parts, all ISO-8601. 2026-05-17 is a Sunday — the case the engines disagree on
-- most, answering 0, 1 or 7 natively — and it falls in ISO week 20, quarter 2, on day 137.
SELECT
  quarter(t.type_date) AS q
, WEEKOFYEAR(t.type_date) AS wk
, (WEEKDAY(t.type_date) + 1) AS dow
, day(t.type_date) AS dom
, dayofyear(t.type_date) AS doy
, (DATE(t.type_date) - INTERVAL WEEKDAY(t.type_date) DAY) AS wk_begin
, (DATE(t.type_date) - INTERVAL WEEKDAY(t.type_date) DAY + INTERVAL 6 DAY) AS wk_end
FROM
 check_type t