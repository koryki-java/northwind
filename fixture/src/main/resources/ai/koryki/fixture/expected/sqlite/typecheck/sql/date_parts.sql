-- The calendar parts, all ISO-8601. 2026-05-17 is a Sunday — the case the engines disagree on
-- most, answering 0, 1 or 7 natively — and it falls in ISO week 20, quarter 2, on day 137.
SELECT
  ((CAST(strftime('%m', t.type_date) AS INTEGER) + 2) / 3) AS q
, ((CAST(strftime('%j', date(t.type_date, '-3 days', 'weekday 4')) AS INTEGER) - 1) / 7 + 1) AS wk
, (((CAST(strftime('%w', t.type_date) AS INTEGER) + 6) % 7) + 1) AS dow
, CAST(strftime('%d', t.type_date) AS INTEGER) AS dom
, CAST(strftime('%j', t.type_date) AS INTEGER) AS doy
, date(t.type_date, '-6 days', 'weekday 1') AS wk_begin
, date(t.type_date, 'weekday 0') AS wk_end
FROM
 check_type t