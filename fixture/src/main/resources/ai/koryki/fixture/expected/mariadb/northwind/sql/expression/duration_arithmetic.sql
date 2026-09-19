-- The four shapes TEMPORAL.md promises for applying a duration, pinned across every dialect:
--   DATE + calendar-only duration stays a DATE
--   DATE + a duration with a clock component becomes a TIMESTAMP (TEMPORAL.md, "Arithmetic")
--   TIMESTAMP + duration stays a TIMESTAMP
--   a negated duration flips EVERY component
-- The last one used to be built as negate(2d4h). Two things went wrong with that: dialects that
-- render a duration as a chain (a + b) got -(a + b), which oracle, mariadb and trino reject and
-- which — before the parentheses were added — bound the minus to the first component alone, so
-- -2d4h meant -2d + 4h. And the negate() wrapper hid the duration from the DATE-to-TIMESTAMP
-- promotion, so trino, mssql and sqlite silently skipped it. Folding the sign into the literal
-- at map time fixes both at once.
SELECT
  o.order_date + INTERVAL '2' DAY AS calendar_only
, o.order_date + INTERVAL '2' DAY + INTERVAL '4' HOUR AS date_plus_clock
, o.delivered_date + INTERVAL '2' DAY + INTERVAL '4' HOUR AS timestamp_plus_clock
, o.order_date + INTERVAL '-2' DAY + INTERVAL '-4' HOUR AS negated
FROM
 orders o
WHERE
  o.order_id = 10248