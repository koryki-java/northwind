-- The calendar parts, all ISO-8601. 2026-05-17 is a Sunday — the case the engines disagree on
-- most, answering 0, 1 or 7 natively — and it falls in ISO week 20, quarter 2, on day 137.
SELECT
  EXTRACT(QUARTER FROM t.type_date) AS q
, EXTRACT(WEEK FROM t.type_date) AS wk
, EXTRACT(ISODOW FROM t.type_date) AS dow
, EXTRACT(DAY FROM t.type_date) AS dom
, EXTRACT(DOY FROM t.type_date) AS doy
, date_trunc('week', t.type_date) AS wk_begin
, CAST(date_trunc('week', t.type_date) + INTERVAL '6 days' AS DATE) AS wk_end
FROM
 check_type t