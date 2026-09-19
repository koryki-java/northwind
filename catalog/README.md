# koryki catalog

The catalog files a koryki implementation needs in order to resolve queries:

- **`db.json`** — the physical schema: tables, columns, types, keys, relations.
- **`model.json`** — the semantic layer per language: entities, attributes, links with their names
  and descriptions. These names are the vocabulary KQL is written in.

They live here rather than in the individual modules because several implementations need them —
the Java implementation via the classpath.

## Layout

The directories under `src/main/resources/` **are** the classpath paths under which the
`CatalogLoader` looks for the files. They must therefore not be rearranged.

Two rules, and the path tells you which one applies:

```
ai/koryki/databases/<schema>/            shared — one catalog that all dialects read
ai/koryki/<dialect>/databases/<schema>/  per dialect, because the physical types differ
```

`<schema>` is `northwind`, `typecheck` or `temporal`; below it live `db.json` and
`model/<locale>/model.json` with `<locale>` = `en` or `de`.

The difference is not a formality. `northwind` is **dialect-neutral** — its type names are those of
the standard (`character varying`, `smallint`, `real`), and the same catalog answers the queries for
all eight dialects. `temporal` and `typecheck`, by contrast, exist per dialect with that dialect's
own type names (`TIMESTAMP`, `INTERVAL`, `NUMBER`), because those very differences are what they
check.

Until July 2026 the shared northwind catalog lived under `ai/koryki/databases/duckdb/northwind/`.
The path lied: it named a dialect for something everyone reads, and forced every implementation into
a special rule. The duckdb-specific catalogs moved to `ai/koryki/duckdb/databases/` in the process,
where those of the other seven already were.

One exception remains:

```
ai/koryki/core/oraview/   special case for the view tests, without a databases level
```

## Why each dialect gets its own db.json

The same table has different types per database — Oracle has no `BIGINT`, SQLite no `NUMBER`. The
`db.json` reflects that. The `model.json`, by contrast, is the business view and is structurally
identical across dialects.
