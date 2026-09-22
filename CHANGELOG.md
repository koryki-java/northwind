# Changelog

All notable changes to this project are documented here. 

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

[Unreleased]: https://github.com/koryki-java/northwind/compare/v0.1.1...HEAD
[0.1.1]: https://github.com/koryki-java/northwind/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/koryki-java/northwind/releases/tag/v0.1.0
