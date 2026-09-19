-- The calendar parts, all ISO-8601. 2026-05-17 is a Sunday — the case the engines disagree on
-- most, answering 0, 1 or 7 natively — and it falls in ISO week 20, quarter 2, on day 137.
SELECT
  TO_NUMBER(TO_CHAR(t.type_date, 'Q')) AS q
, TO_NUMBER(TO_CHAR(t.type_date, 'IW')) AS wk
, (TRUNC(t.type_date) - TRUNC(t.type_date, 'IW') + 1) AS dow
, EXTRACT(DAY FROM t.type_date) AS dom
, TO_NUMBER(TO_CHAR(t.type_date, 'DDD')) AS doy
, TRUNC(t.type_date, 'IW') AS wk_begin
, (TRUNC(t.type_date, 'IW') + 6) AS wk_end
FROM
 check_type t