-- A timestamp literal written with milliseconds must reach the database with them. TIMESTAMP_STRING
-- ends in an optional '.' DIGIT DIGIT DIGIT and both mappers parse it, but every dialect rendered
-- through its own ofPattern("yyyy-MM-dd HH:mm:ss") — no fractional part — so the value was parsed,
-- carried through the model, and dropped at the very last step. The query then asked for half a
-- second earlier than it says, on five of eight engines, without a word.
SELECT
  COUNT(*) AS after_the_half_second
FROM
 orders o
WHERE
  o.delivered_date > TIMESTAMP '2022-07-16 12:38:17.500'