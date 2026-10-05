-- Steps follow the structure to any depth: a list of structs, a struct holding a list, a list of
-- maps of structs holding a list and a map of lists. Each step is checked against the type it meets.
SELECT
  t.nr
, t.items[1]['sku'] AS first_sku
, t.items[1]['price'] AS first_price
, t.items[1]['opts'][2] AS second_option
, t.items[2]['opts'] AS empty_options
, t.events[1]['ts'] AS first_event
, t.events[1]['day'] AS first_day
, t.deep[1]['m']['a'][2] AS deep_number
, t.deep[1]['m']['b'][1][1] AS deep_text
, t.items[2:2] AS second_item
FROM
 check_complex t