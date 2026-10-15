# Changelog

All notable changes to this project are documented here. 

## [unreleased]

### Changed

- **Breaking:** every `db.json` says what a column is, and what it means, in a `concept` of the
  column (`typeFamily`, `typeEncoding`, `dialectType`, `label`, `comment`, `description`, `unit`,
  `quantity`, `presentation`), or in a `conceptRef` naming a concept of the schema's `concepts`.
  The same fields directly on a column are gone. A reader of the old layout, such as `koryki-core`
  0.2.1 or the released `koryki-derivation`, no longer reads these catalogs; `koryki-core` and
  `koryki-derivation` have to be released with them.
- A concept of a container (ARRAY, STRUCT, MAP, JSON with a declared shape) names its parts in
  `entries`, each the spelling of a type, the name of a concept, or a concept of its own.
- The complex and temporal models say in their own words everything their schema says: the
  attributes carry the wording of the parts of nested columns as `members`, and
  `time_sec_from_midnight` its description. The German Northwind model has the two labels it left
  out (`shippers.company_name`, `suppliers.phone`).

### Added

- `check_shared` on every dialect: a table whose columns `home` and `work`, and the elements of
  `route`, are one concept `point`, defined once in the `concepts` of the schema and worded once in a
  `notions` entry of the model, in English and German. DuckDB, PostgreSQL (composite type), Oracle
  (object type and VARRAY), Trino and Snowflake store it natively, MariaDB, SQL Server and SQLite as
  JSON. Catalog `<dialect>/databases/shared`, script `data_check_shared.sql`, and a `createShared`
  task for PostgreSQL, MariaDB, Oracle, SQL Server and Snowflake that creates only that table. On
  Trino the script runs with `createDatabase`; in SQLite it is part of the built database.
- `CatalogWordingTest` in the `catalog` module: every model leaves no word of its `db.json`
  unsaid, for the columns, for the parts of nested columns and for the shared concepts.
- `check_complex` in the DuckDB database: one column per shape of ARRAY, STRUCT, MAP and JSON,
  nested up to four levels, three rows (full, empty or NULL containers, NULL elements). Catalog
  `duckdb/databases/complex` and eight fixture queries with their goldens.
- The database builders of the other dialects moved here from `koryki-java/core`: modules
  `postgresql`, `mariadb`, `oracle`, `mssql`, `snowflake` and `sqlite` hold the scripts and a
  `createDatabase` task each, `loader` the shared script splitter and connection. A schema change no
  longer needs a release of `core`.
- `koryki-northwind-sqlite`: the SQLite database, built from the scripts when the artifact is built.
  `core` no longer carries a committed `northwind.sqlite`.

## [0.1.2] - 2026-09-22

### Changed

- POM metadata: added an `<organization>` block (`koryki`, https://koryki.ai), and rewrote the
  `koryki-northwind-catalog` and `koryki-northwind-duckdb` descriptions to name the project and its
  purpose instead of only listing the files in the jar — both were indexed by Maven Central Search
  and mvnrepository.com under the old, terser text.
- Corrected the POM developer contact email.

### Fixed

- `README.md` and `SECURITY.md` still referenced the pre-0.1.1 artifact ID `koryki-catalog` in
  dependency snippets and verification commands; both now say `koryki-northwind-catalog`.

## [0.1.1] - 2026-09-20

### Changed

- **Breaking:** renamed the `catalog` module's Maven artifact ID from `koryki-catalog` to
  `koryki-northwind-catalog`, matching `koryki-northwind-duckdb`'s naming.

## [0.1.0] - 2026-09-20

Initial release. Publishes two signed artifacts to Maven Central:

- `ai.koryki.northwind:koryki-catalog` — `db.json` (physical schema) and `model.json` (semantic
  layer) for the shared test databases.
- `ai.koryki.northwind:koryki-northwind-duckdb` — DDL, per-table data scripts and the prebuilt
  `northwind.duckdb` for the Northwind sample database.

Both ship with sources and javadoc jars, `LICENSE`/`NOTICE` bundled into every jar, JAR
specification/implementation manifest attributes, JaCoCo coverage reports, and code formatted with
Spotless (`google-java-format`, AOSP style). Releases are signed in CI with an in-memory PGP key and
published to Maven Central via the Central Portal.

[Unreleased]: https://github.com/koryki-java/northwind/compare/v0.2.1...HEAD
[0.1.2]: https://github.com/koryki-java/northwind/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/koryki-java/northwind/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/koryki-java/northwind/releases/tag/v0.1.0
