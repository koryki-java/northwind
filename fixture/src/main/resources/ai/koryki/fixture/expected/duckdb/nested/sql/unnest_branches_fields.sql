-- One row per branch of a native list of structs, with its fields and a field of the struct inside.
-- (On Snowflake the latitude of row 3, which has no position, comes back as the text "null" - a JSON
-- null of the untyped value FLATTEN yields, not an SQL NULL - where the other dialects have an empty
-- cell. Its SQL is still checked.)
SELECT
  t.nr
, b.item['street']
, b.item['city']
, b.item['zip']
, b.item['geo']['lat'] AS latitude
FROM
 check_complex t
  INNER JOIN UNNEST(t.branches) AS b(item) ON TRUE