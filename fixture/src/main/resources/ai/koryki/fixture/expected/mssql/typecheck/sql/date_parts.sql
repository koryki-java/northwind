-- The calendar parts, all ISO-8601. 2026-05-17 is a Sunday — the case the engines disagree on
-- most, answering 0, 1 or 7 natively — and it falls in ISO week 20, quarter 2, on day 137.
SELECT
  DATEPART(quarter, t.type_date) AS q
, DATEPART(iso_week, t.type_date) AS wk
, ((DATEDIFF(day, '19000101', t.type_date) % 7) + 1) AS dow
, day(t.type_date) AS dom
, DATEPART(dayofyear, t.type_date) AS doy
, DATEADD(day, -(DATEDIFF(day, 0, t.type_date) % 7), CAST(t.type_date AS DATE)) AS wk_begin
, DATEADD(day, 6 - (DATEDIFF(day, 0, t.type_date) % 7), CAST(t.type_date AS DATE)) AS wk_end
FROM
 check_type t