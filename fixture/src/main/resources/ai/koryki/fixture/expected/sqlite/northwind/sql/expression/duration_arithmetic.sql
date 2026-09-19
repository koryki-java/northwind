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
  date(o.order_date, '+2 days') AS calendar_only
, datetime(o.order_date, '+2 days', '+4 hours') AS date_plus_clock
, datetime(o.delivered_date, '+2 days', '+4 hours') AS timestamp_plus_clock
, datetime(o.order_date, '-2 days', '-4 hours') AS negated
FROM
 orders o
WHERE
  o.order_id = 10248