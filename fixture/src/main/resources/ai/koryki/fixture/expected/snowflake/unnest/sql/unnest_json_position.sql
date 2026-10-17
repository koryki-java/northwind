-- The position of the element in the JSON array, from 1.
SELECT
  t.nr
, (b.INDEX + 1)
, b.VALUE::INTEGER
FROM
 check_complex t
  , LATERAL FLATTEN(INPUT => TRANSFORM(CAST(GET_PATH(t.doc, 'a.b') AS ARRAY), e -> CAST(e AS INTEGER))) b