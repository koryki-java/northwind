-- Three rows: fully populated, empty/NULL containers, NULL elements inside containers.
-- branches and branches_json hold the same three branches in row 1, an empty list in row 2 and one
-- branch with NULL parts in row 3 - the two columns must answer every question the same way.
-- Maps hold at most two keys, inserted in a fixed order, so rendered rows are stable.
INSERT INTO check_complex (
    nr, tags, scores, vec, matrix, dims, address, attrs, counts, lookup,
    items, events, deep, doc, odd, branches, branches_json
)
VALUES (
    1,
    ['red', 'green', 'blue'],
    [10, 20, 30],
    [1.0, 2.0, 3.0],
    [[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]],
    {'w': 1.5, 'h': 2.5},
    {'street': 'Main St 1', 'geo': {'lat': 52.52, 'lon': 13.405}, 'phones': ['+49 30 1', '+49 30 2']},
    MAP {'color': 'red', 'size': 'L'},
    MAP {'a': 1, 'b': 2},
    MAP {1: 'one', 2: 'two'},
    [{'sku': 'A-1', 'qty': 2, 'price': 9.99, 'opts': ['x', 'y']},
     {'sku': 'B-2', 'qty': 1, 'price': 24.50, 'opts': []}],
    [{'ts': TIMESTAMP '2026-05-17 14:30:45', 'day': DATE '2026-05-17'}],
    [MAP {'m': {'a': [1, 2], 'b': MAP {1: ['q', 'r']}}}],
    '{"a": {"b": [5, 6]}, "n": 1}'::JSON,
    {'Odd Name': 1, 'x': 2},
    [{'street': 'Hafenstrasse 4', 'city': 'Hamburg', 'zip': '20457', 'geo': {'lat': 53.54, 'lon': 9.99}},
     {'street': 'Domshof 2', 'city': 'Bremen', 'zip': '28195', 'geo': {'lat': 53.08, 'lon': 8.81}},
     {'street': 'Holstenstrasse 9', 'city': 'Kiel', 'zip': '24103', 'geo': {'lat': 54.32, 'lon': 10.14}}],
    '[{"street": "Hafenstrasse 4", "city": "Hamburg", "zip": "20457", "geo": {"lat": 53.54, "lon": 9.99}},
      {"street": "Domshof 2", "city": "Bremen", "zip": "28195", "geo": {"lat": 53.08, "lon": 8.81}},
      {"street": "Holstenstrasse 9", "city": "Kiel", "zip": "24103", "geo": {"lat": 54.32, "lon": 10.14}}]'::JSON
),
(
    2,
    [],
    [],
    NULL,
    NULL,
    NULL,
    {'street': NULL, 'geo': NULL, 'phones': []},
    MAP {},
    MAP {},
    NULL,
    [],
    [],
    [],
    NULL,
    NULL,
    [],
    '[]'::JSON
),
(
    3,
    ['x', NULL, 'z'],
    [NULL, 5, NULL],
    [0.0, NULL, 3.0],
    [[1.0, NULL, 3.0], [NULL, 5.0, 6.0]],
    {'w': NULL, 'h': 4.0},
    {'street': 'Side Rd 3', 'geo': {'lat': NULL, 'lon': NULL}, 'phones': [NULL]},
    MAP {'k': NULL},
    MAP {'z': NULL},
    MAP {3: NULL},
    [{'sku': 'C-3', 'qty': NULL, 'price': NULL, 'opts': NULL}],
    [{'ts': NULL, 'day': DATE '2026-01-01'}],
    [MAP {'m': {'a': NULL, 'b': NULL}}],
    '[1, 2, 3]'::JSON,
    {'Odd Name': NULL, 'x': NULL},
    [{'street': NULL, 'city': 'Luebeck', 'zip': NULL, 'geo': {'lat': NULL, 'lon': NULL}}],
    '[{"street": null, "city": "Luebeck", "zip": null, "geo": {"lat": null, "lon": null}}]'::JSON
);

-- The lists of check_complex flattened into one row per element (FlattenViews in the tools module of
-- core generates them): the key of the row, the position in the list from 1, and a column for each field
-- of the element, or "value". UNNEST ... WITH ORDINALITY.
CREATE OR REPLACE VIEW check_complex_tags AS
SELECT t.nr, u.ordinal, u.item AS value
FROM check_complex t, UNNEST(t.tags) WITH ORDINALITY AS u(item, ordinal);

CREATE OR REPLACE VIEW check_complex_items AS
SELECT t.nr, u.ordinal, u.item.sku AS sku, u.item.qty AS qty, u.item.price AS price, u.item.opts AS opts
FROM check_complex t, UNNEST(t.items) WITH ORDINALITY AS u(item, ordinal);

CREATE OR REPLACE VIEW check_complex_events AS
SELECT t.nr, u.ordinal, u.item.ts AS ts, u.item.day AS day
FROM check_complex t, UNNEST(t.events) WITH ORDINALITY AS u(item, ordinal);
