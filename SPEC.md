# Fixture corpus format — SPEC

**Format version: 1**

This document is the language-neutral contract for the shared test-fixture corpus under
`fixture/src/main/resources/ai/koryki/fixture/`. Any implementation should be able to build a
conformance-test harness against this document alone, without reading any implementation's source
code. Where the corpus still depends on how the Java implementation happens to behave, this document
says so — see [Known limitations](#known-limitations).

If a future change to the directory layout, marker syntax, or golden format would break an
existing harness, the format version above must be bumped and the change called out in this
repository's release notes for that version.

## What locates the corpus

A harness needs exactly two configuration values:

1. **Root** — the filesystem path to a checkout of this repository (`northwind`).
2. **Corpus base** — the fixed relative path `fixture/src/main/resources/ai/koryki/fixture` under
   that root.

There is no environment auto-detection and no classpath/resource lookup: the corpus is read
straight off the filesystem by joining these two values, and nothing more. A harness is expected to
fail loudly if the root is unset or does not resolve to a real directory — a silently-empty corpus
must never look like a passing run.

(The Java implementation follows this exactly: `Fixtures` reads the root from the `test.root` system
property and the base from `test.corpus`, which its build sets to the fixed path above; an unset or
missing directory is a hard error, not a fallback to zero test cases.)

## Layout

```
queries/kql/<schema>/…/<name>.kql                    the queries — the same for all dialects
iql/<schema>/…/<name>.iql                            IQL sources
expected/kql/<schema>/csv/…/<name>.csv               result — shared by all dialects
expected/kql/<schema>/csv/…/<name>.json              result column types — shared by all dialects
expected/kql/<schema>/sql/…/<name>.sql               SQL from the reference renderer
expected/kql/<schema>/iql/…/<name>.iql               the query serialized as IQL
expected/kql/<schema>/de/…/<name>_de.txt             the query translated to German
expected/iql/<schema>/sql/…/<name>.sql               SQL generated from the IQL sources
expected/<dialect>/<schema>/sql/…/<name>.sql         SQL — per dialect
expected/<dialect>/<schema>/violations/…/<name>.txt  what the dialect rejects — per dialect
```

`<schema>` is `northwind`, `typecheck`, `temporal` or `casts`. `<dialect>` is the name of a database:
every directory under `expected/` other than `kql` and `iql` is one (`duckdb`, `mariadb`, `mssql`,
`oracle`, `postgresql`, `snowflake`, `sqlite`, `trino`). In that position `kql` stands for
"dialect-independent", and `iql` for the expectations belonging to the IQL sources rather than to
the KQL queries. German translations exist for `northwind` only.

A golden's path is the query's path relative to its schema directory, with the suffix replaced as
shown above. So `queries/kql/northwind/rewrite/date_between.kql` belongs to
`expected/duckdb/northwind/sql/rewrite/date_between.sql`.

The reference SQL under `expected/kql/<schema>/sql` is not dialect-free: it is rendered with DuckDB's
base dialect in UTC. A query that dialect rejects has no reference SQL, IQL or German golden.

## Queries

Queries are UTF-8 text in the respective query language. Leading `//` comment lines describe the
query and may carry markers. Each non-empty one reappears as a `-- <text>` line at the top of every
SQL golden; empty comment lines and markers do not.

Two file-name conventions apply:

- A query whose file name starts with **`invalid`** must fail to parse or validate. It is never
  executed and has no goldens.
- A query whose name (without extension) ends in **`stable`** has a significant row order; see
  [CSV goldens](#csv-goldens).

## The `// ignore=<dialect>` marker

A comment line `// ignore=<dialect>` in a query file — one line per dialect — excludes that dialect
from the shared CSV check for this query. It means exactly one thing: *same SQL, different result* —
a dialect's own semantics (rounding, date arithmetic, collation, …) legitimately produce a different
result here even though the generated SQL is right.

The dialect's SQL golden is therefore still checked; only its result is excluded. If the query cannot
be rendered on that dialect at all, the marker is the wrong remedy and the run must fail. "This
dialect can't do that" is not expressed by a marker — it is derived from the dialect description and
produces a violation golden instead.

## When a dialect cannot run a query

A dialect may reject a query because it cannot express a function or construct, or because its
schema lacks a column the query reads. The query is then skipped on that dialect — but only if
*every* error is of one of those two kinds; a query that is rejected for any other reason fails.

A skip is recorded in a **violation golden** under `expected/<dialect>/<schema>/violations/`. Without
it a skipped case would be invisible, and a skip that appears or disappears would look like a
passing run. Both directions must fail a conformant harness: a rejection without a violation golden,
and a violation golden that is still present although the dialect now runs the query. A rejected
query has no SQL golden for that dialect.

## Comparing a golden

Every file is UTF-8 with LF line endings. A harness compares a golden line by line:

1. Split both texts into lines. Trailing empty lines are not significant, and neither is a trailing
   `\r` on a line.
2. Both must have the same number of lines, and each line must be equal — except for the numeric
   tolerance of [CSV goldens](#csv-goldens).

### SQL goldens

`expected/**/sql/*.sql`: the rendered SQL, compared exactly.

### CSV goldens

`expected/kql/<schema>/csv/*.csv`: the query result, shared by all dialects.

- The first line holds the column headers, every further line one row.
- Every cell is enclosed in `"`, with an embedded `"` doubled, and cells are separated by `, `
  (comma and space): `"Id", "Delivered Date"`. SQL `NULL` is written as `""`.
- Rows are sorted by their rendered line, as plain string comparison, and the header stays first —
  unless the query is `stable`, in which case they keep the order the query returns them in. (The
  Java implementation compares strings by UTF-16 code unit; this differs from code point order only
  for characters outside the Basic Multilingual Plane.)
- Values are rendered canonically and locale-independently, by the type family of their column:

  | Family      | Rendering |
  |-------------|-----------|
  | `INTEGER`   | plain digits |
  | `DECIMAL`   | rounded half-up to 6 decimal places, trailing zeros removed, no exponent: `12.5`, `830` |
  | `FLOAT`     | rounded half-up to 6 significant digits, trailing zeros removed, no exponent |
  | `BOOLEAN`   | `true` or `false` |
  | `DATE`      | `yyyy-MM-dd` |
  | `TIME`      | `HH:mm:ss` — fractional seconds are cut off |
  | `TIMESTAMP` | `yyyy-MM-dd HH:mm:ss` — fractional seconds are cut off |
  | `INTERVAL`  | KQL duration notation: units `y`, `mo`, `d`, `h`, `min`, `s` in that order, zero units omitted, each unit signed on its own (`-3h-20min-30s`), zero as `0s` |
  | `TEXT`      | verbatim — except text that is a decimal number containing `.`, which is rendered as `DECIMAL`, and ISO date, time or timestamp text, which is rendered as that family |

- Two lines that differ still match if they have the same number of cells and every pair of
  differing cells holds two numbers (quotes removed) whose difference is less than `1e-6` relative
  to the larger absolute value. Engines legitimately disagree in the last digits of a
  floating-point result, since addition order changes it.

### Type goldens

`expected/kql/<schema>/csv/*.json`: the type family of each result column, shared by all dialects.
Despite the suffix this is not JSON — see [Known limitations](#known-limitations). One line per
column, in column order: `<header> : <FAMILY>`, with `unknown` where no type is known. `<FAMILY>` is
one of the families in the table above. Only the family is recorded: the physical type legitimately
differs between engines, the family must not.

### IQL and translation goldens

`expected/kql/<schema>/iql/*.iql` holds the query serialized as IQL, and
`expected/kql/northwind/de/*_de.txt` the query with the `northwind` vocabulary translated to German
(the `de` model of the catalog). Both pin the output of the reference implementation's serializer
and formatter, so another implementation checks them only if it provides those.

### Violation goldens

`expected/<dialect>/<schema>/violations/*.txt`: one line per error, in the form

```
<category>: <node> [<line>:<column>-<line>:<column>]: <message>
```

- `<category>` is `unsupported` (the dialect cannot express a function or construct) or
  `schema.unknown-column` (the dialect's schema has no such column).
- `<node>` names the kind of construct that was rejected: `Function`, `Expression` or `Field`.
- The range is 1-based. It starts at the first character of the construct and ends one column past
  its last: `initcap(c.contact_name)` beginning in column 7 of line 3 is `[3:7-3:30]`.
- `<message>` is the reference implementation's English description of the error.
- Lines appear in the order the reference implementation's validator reports them, which is not
  source order. Compare them as a multiset.

## Why CSV is shared but SQL is not

The generated SQL differs per dialect — that is the whole point of a transpiler. The **result** is
expected not to: by default, the same query has to return the same rows everywhere, which is why
the CSV lives once under `expected/kql/<schema>/csv` and all dialects check against the same
golden. If one deviates without saying so, that is precisely the finding.

This is a default, not a universal guarantee — the `// ignore=<dialect>` marker is the documented
exception: a dialect whose own semantics legitimately return a different result for an
otherwise-identical query is excluded from the shared-CSV check for that one query, explicitly and
per-case, never silently.

## Known limitations

These are properties of format version 1 that a later version should remove:

- **Type goldens end in `.json` but are not JSON.** Tools that treat the suffix as a promise will
  reject them.
- **`NULL` and the empty string are indistinguishable** in a CSV golden; both are `""`.
- **Violation goldens carry the Java implementation's vocabulary.** `<node>` is the name of its
  syntax-tree class and `<message>` its prose. Another implementation has to reproduce both verbatim,
  or compare only category and range.
- **The reference SQL is DuckDB's.** It duplicates `expected/duckdb/<schema>/sql`, and a query DuckDB
  rejects has no reference SQL, IQL or German golden.
- **Non-reproducible results have no marker of their own.** A query whose result differs on every
  run (`random()`, `now()`, `today()`, `clock_now()`) carries an `ignore=` marker for every dialect and
  therefore has no CSV golden. A new dialect has to add its marker to each such query.

## Creating goldens

A missing golden file must never be written automatically by a normal run — the run must abort and
name the expected path. Otherwise an accidentally deleted golden would, on the next run, merely
confirm the current behaviour, and the test would be checking itself.

An explicit, opt-in write mode may exist per implementation (Java: `-Dfixtures.write=true`) to
generate goldens deliberately. **This corpus is shared across implementations — a write mode must
never be the default, and no implementation should assume it is the only writer.**

## Checking the corpus

`./gradlew test` in this repository checks the corpus without running any implementation. It
verifies that the query directories hold only queries, that every golden belongs to an existing
query, that no dialect has both an SQL golden and a violation golden for the same query, and that
every `ignore=` marker names a dialect. It also checks that every catalog file is strict JSON. A
harness walks from each query to its goldens and cannot see a golden whose query was renamed or
deleted — these checks walk the other way.
