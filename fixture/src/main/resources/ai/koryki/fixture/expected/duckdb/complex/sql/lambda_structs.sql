-- The parameter is the element, whatever it is: a struct from a list of structs, and a step selects
-- from it. A lambda inside a lambda sees both parameters.
SELECT
  t.nr
, list_transform(t.items, _l0_it -> _l0_it['price'] * _l0_it['qty']) AS line_totals
, list_transform(t.items, _l0_it -> _l0_it['sku']) AS skus
, list_transform(t.items, _l0_it -> list_transform(_l0_it['opts'], _l1_o -> upper(_l1_o))) AS options
FROM
 check_complex t