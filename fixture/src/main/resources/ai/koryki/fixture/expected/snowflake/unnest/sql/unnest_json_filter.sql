-- A filter on the rows of the JSON array keeps the matching elements.
SELECT
  t.nr
, b.VALUE::INTEGER
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => TRANSFORM(CAST(GET_PATH(t.doc, 'a.b') AS ARRAY), e -> CAST(e AS INTEGER))) b
WHERE
  b.VALUE::INTEGER > 5