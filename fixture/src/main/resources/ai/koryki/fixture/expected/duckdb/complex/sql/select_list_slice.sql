-- A range selects a list: @1:2 the first two, @2: from the second to the end, @:2 up to the second.
-- Both ends are included. The slice of a fixed-size array is a list.
SELECT
  t.nr
, t.tags[1:2] AS first_two
, t.tags[2:] AS from_second
, t.tags[:2] AS up_to_second
, t.vec[1:2] AS vec_head
FROM
 check_complex t