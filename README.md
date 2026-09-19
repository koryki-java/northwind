# koryki northwind

[![Build](https://github.com/koryki-java/northwind/actions/workflows/build.yml/badge.svg)](https://github.com/koryki-java/northwind/actions/workflows/build.yml)

The shared test data of koryki: schema catalogs, the Northwind database for DuckDB, and a query
corpus. It is a project of its own so that every implementation runs against the **same** cases.

| Module | Holds | Consumed as |
|---|---|---|
| [`catalog`](catalog/README.md) | `db.json` (physical schema) and `model.json` (semantic layer) of the test databases | Maven artifact `ai.koryki.northwind:koryki-catalog` |
| `duckdb` | the Northwind database for DuckDB: DDL, data scripts and the prebuilt `northwind.duckdb` | Maven artifact `ai.koryki.northwind:koryki-northwind-duckdb` |
| `fixture` | KQL and IQL queries with their expected SQL, results and rejections per dialect | a checkout of this repository, not published |

The databases of the other dialects are set up by their modules in `core`.

## Maven and Gradle

### catalog

`koryki-catalog` is an ordinary dependency. Most projects need it only for tests; use
`implementation` / `compile` scope instead if your main code reads the catalog, as `koryki-northwind`
in `core` does.

Gradle (Groovy DSL):

```groovy
dependencies {
    testImplementation 'ai.koryki.northwind:koryki-catalog:0.1.0'
}
```

Gradle (Kotlin DSL):

```kotlin
dependencies {
    testImplementation("ai.koryki.northwind:koryki-catalog:0.1.0")
}
```

Maven:

```xml
<dependency>
  <groupId>ai.koryki.northwind</groupId>
  <artifactId>koryki-catalog</artifactId>
  <version>0.1.0</version>
  <scope>test</scope>
</dependency>
```

The files are read from the classpath, e.g. `/ai/koryki/databases/northwind/db.json`;
[`catalog/README.md`](catalog/README.md) describes the layout.

### duckdb

`koryki-northwind-duckdb` holds files only, all below `/ai/koryki/duckdb/databases/northwind/`:
`db/tables.sql`, one `db/data_<table>.sql` per table, and `northwind.duckdb`, the database built
from them. `koryki-northwind` in `core` brings it along, so most projects never name it; to read the
files directly:

```groovy
dependencies {
    testRuntimeOnly 'ai.koryki.northwind:koryki-northwind-duckdb:0.1.0'
}
```

```kotlin
dependencies {
    testRuntimeOnly("ai.koryki.northwind:koryki-northwind-duckdb:0.1.0")
}
```

```xml
<dependency>
  <groupId>ai.koryki.northwind</groupId>
  <artifactId>koryki-northwind-duckdb</artifactId>
  <version>0.1.0</version>
  <scope>test</scope>
</dependency>
```

`northwind.duckdb` is built from the scripts, here:

```
./gradlew :duckdb:buildDatabase     # writes duckdb/build/northwind.duckdb
./gradlew :duckdb:updateDatabase    # replaces the committed northwind.duckdb with a fresh build
```

`./gradlew test` fails when the committed database no longer matches its scripts. It is built with
the DuckDB version `core` uses; a newer one may write a format `core` cannot read.

### fixture

The corpus is not a Maven artifact: an implementation reads it straight from a checkout of this
repository, usually a git submodule pinned to a commit or tag.

```
git submodule add https://github.com/koryki-java/northwind.git northwind-fixtures
```

After cloning a project that already has the submodule, run `git submodule update --init` (on
GitHub Actions: `actions/checkout` with `submodules: true`).

The Java harness in `core` (`Fixtures`) reads two system properties and aborts with a named message
if either is missing: `test.root`, the checkout, and `test.corpus`, the corpus path below it. Tests
run in a forked JVM, so the build has to pass both on.

Gradle (Groovy DSL):

```groovy
tasks.withType(Test).configureEach {
    // -Ptest.root=... points at another checkout, e.g. one with unreleased fixture changes.
    def root = providers.gradleProperty('test.root').orNull ?: rootProject.file('northwind-fixtures').path
    def corpus = 'fixture/src/main/resources/ai/koryki/fixture'
    systemProperty 'test.root', root
    systemProperty 'test.corpus', corpus
    // The corpus lives outside src/; without this input a changed fixture leaves the tests UP-TO-DATE.
    inputs.dir("$root/$corpus")
            .withPathSensitivity(PathSensitivity.RELATIVE)
            .withPropertyName('fixtures')
}
```

Maven:

```xml
<properties>
  <!-- mvn test -Dtest.root=... points at another checkout -->
  <test.root>${project.basedir}/northwind-fixtures</test.root>
</properties>

<build>
  <plugins>
    <plugin>
      <groupId>org.apache.maven.plugins</groupId>
      <artifactId>maven-surefire-plugin</artifactId>
      <configuration>
        <systemPropertyVariables>
          <test.root>${test.root}</test.root>
          <test.corpus>fixture/src/main/resources/ai/koryki/fixture</test.corpus>
        </systemPropertyVariables>
      </configuration>
    </plugin>
  </plugins>
</build>
```

The full, language-neutral contract — directory layout, file formats, markers, how goldens are
compared and created — lives in [`SPEC.md`](SPEC.md). Read that before writing a new implementation
against this corpus; nothing here duplicates it.

## Checking a change

```
./gradlew test
```

checks the corpus and the catalog without running any implementation (JDK 21 required): that every
golden belongs to a query, that no dialect both renders and rejects a query, that every `ignore=`
marker names a dialect, that every catalog file is strict JSON, and that `northwind.duckdb` matches
its scripts. Run it before committing a fixture, golden or script.

Enable the pre-push hook once per clone, so a key or password is caught before it reaches GitHub:

```
git config core.hooksPath githooks
```

It scans the commits being pushed and rejects the push if it finds a credential — with
[gitleaks](https://github.com/gitleaks/gitleaks) when installed, otherwise with a few built-in
patterns. `git push --no-verify` overrides it for a false positive. The `Secret scan` workflow
checks the full history on every push as well.

## Versions

- `v<version>` tags release `koryki-catalog` and `koryki-northwind-duckdb` to Maven Central. The tag
  must match `version` in `gradle.properties`, or the release workflow stops.
- The corpus is not published: implementations pin a commit or a `v<version>` tag. Its format has a
  version of its own, stated at the top of [`SPEC.md`](SPEC.md).

## License

Apache-2.0, see [`LICENSE`](LICENSE). The Northwind schema/data this corpus is derived from carries
its own upstream attribution — see [`NOTICE`](NOTICE).
