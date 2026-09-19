-- TEMPORAL.md normative examples as result assertions (java.time reference).
-- Uniform-rendering subset: distances + end functions render identically across
-- dialects. Clamping (month_add) and begin (month_begin) are deferred until the
-- DATE->TIMESTAMP type promotion (task #22) is fixed, since their rendering diverges.
SELECT
  (DATEDIFF(month, CAST('2023-01-31' AS DATE), CAST('2023-03-31' AS DATE)) - CASE WHEN DAY(CAST('2023-03-31' AS DATE)) < DAY(CAST('2023-01-31' AS DATE)) THEN 1 ELSE 0 END) AS whole_two
, (DATEDIFF(month, CAST('2023-01-31' AS DATE), CAST('2023-03-30' AS DATE)) - CASE WHEN DAY(CAST('2023-03-30' AS DATE)) < DAY(CAST('2023-01-31' AS DATE)) THEN 1 ELSE 0 END) AS not_complete_one
, (DATEDIFF_BIG(second, CAST('2023-03-01' AS DATE), CAST('2023-02-01' AS DATE)) / 86400) AS signed_minus28
, EOMONTH(CAST('2024-02-10' AS DATE)) AS end_leap
, EOMONTH(DATEADD(QUARTER, DATEDIFF(QUARTER, 0, CAST('2024-05-20' AS DATE)), 0), 2) AS end_q2
, DATEFROMPARTS(YEAR(CAST('2024-05-20' AS DATE)), 12, 31) AS end_year
FROM
 check_temporal c