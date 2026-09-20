/*
 * Copyright 2025-2026 Johannes Zemlin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package ai.koryki.northwind.fixture;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Checks the corpus against SPEC.md without running any implementation. Harnesses walk from each
 * query to its goldens, so a golden whose query was renamed or deleted is invisible to them; these
 * checks walk the other way.
 */
class CorpusIntegrityTest {

    private static final Path CORPUS = Path.of("src/main/resources/ai/koryki/fixture");
    private static final Path QUERIES = CORPUS.resolve("queries/kql");
    private static final Path IQL = CORPUS.resolve("iql");
    private static final Path EXPECTED = CORPUS.resolve("expected");

    private static final Pattern IGNORE_MARKER = Pattern.compile("// ignore=(\\S*)");

    /** Where the queries of one golden tree live, and which suffix each kind of golden carries. */
    private record Goldens(Path queries, String extension, Map<String, List<String>> suffixes) {}

    private static final Goldens KQL_GOLDENS =
            new Goldens(
                    QUERIES,
                    ".kql",
                    Map.of(
                            "csv", List.of(".csv", ".json"),
                            "sql", List.of(".sql"),
                            "iql", List.of(".iql"),
                            "de", List.of("_de.txt")));

    private static final Goldens IQL_GOLDENS =
            new Goldens(IQL, ".iql", Map.of("sql", List.of(".sql")));

    private static final Goldens DIALECT_GOLDENS =
            new Goldens(
                    QUERIES,
                    ".kql",
                    Map.of(
                            "sql", List.of(".sql"),
                            "violations", List.of(".txt")));

    @BeforeAll
    static void corpusIsThere() {
        assertTrue(
                Files.isDirectory(QUERIES) && Files.isDirectory(EXPECTED),
                () ->
                        "no corpus at "
                                + CORPUS.toAbsolutePath()
                                + " -- run from the fixture module directory");
    }

    @Test
    void queryDirectoriesHoldOnlyQueries() throws IOException {
        List<String> problems = new ArrayList<>();
        for (Path file : files(QUERIES)) {
            if (!file.toString().endsWith(".kql")) {
                problems.add(rel(file));
            }
        }
        for (Path file : files(IQL)) {
            if (!file.toString().endsWith(".iql")) {
                problems.add(rel(file));
            }
        }
        assertNone(
                "files that are not queries (a changed extension silently disables a fixture)",
                problems);
    }

    @Test
    void everyGoldenBelongsToAQuery() throws IOException {
        List<String> problems = new ArrayList<>();
        for (Path golden : files(EXPECTED)) {
            Path query = queryOf(golden);
            if (query == null) {
                problems.add(rel(golden) + "  (not a golden kind SPEC.md defines)");
            } else if (!Files.isRegularFile(query)) {
                problems.add(rel(golden) + "  (no " + rel(query) + ")");
            }
        }
        assertNone("goldens without a query", problems);
    }

    @Test
    void noDialectBothRendersAndRejectsAQuery() throws IOException {
        List<String> problems = new ArrayList<>();
        for (String dialect : dialects()) {
            for (Path schema : subdirectories(EXPECTED.resolve(dialect))) {
                Path violations = schema.resolve("violations");
                for (Path violation : files(violations)) {
                    String name = strip(violations.relativize(violation).toString(), ".txt");
                    Path sql = schema.resolve("sql").resolve(name + ".sql");
                    if (Files.exists(sql)) {
                        problems.add(rel(sql));
                    }
                }
            }
        }
        assertNone(
                "SQL goldens for queries the dialect rejects (see the violation golden beside"
                        + " each); a harness never reads them",
                problems);
    }

    @Test
    void ignoreMarkersNameAKnownDialect() throws IOException {
        Set<String> dialects = dialects();
        List<String> problems = new ArrayList<>();
        for (Path query : files(QUERIES)) {
            Matcher marker = IGNORE_MARKER.matcher(Files.readString(query));
            while (marker.find()) {
                if (!dialects.contains(marker.group(1))) {
                    problems.add(rel(query) + "  (ignore=" + marker.group(1) + ")");
                }
            }
        }
        assertNone("ignore= markers naming no dialect of this corpus " + dialects, problems);
    }

    /** The query a golden belongs to, or null when the path is no golden kind SPEC.md defines. */
    private static Path queryOf(Path golden) {
        Path rel = EXPECTED.relativize(golden);
        if (rel.getNameCount() < 4) {
            return null;
        }
        Goldens goldens =
                switch (rel.getName(0).toString()) {
                    case "kql" -> KQL_GOLDENS;
                    case "iql" -> IQL_GOLDENS;
                    default -> DIALECT_GOLDENS;
                };
        Path schema = rel.getName(1);
        String name = rel.subpath(3, rel.getNameCount()).toString();
        for (String suffix :
                goldens.suffixes().getOrDefault(rel.getName(2).toString(), List.of())) {
            if (name.endsWith(suffix)) {
                return goldens.queries()
                        .resolve(schema)
                        .resolve(strip(name, suffix) + goldens.extension());
            }
        }
        return null;
    }

    /** Every directory below expected/ except the two dialect-independent trees. */
    private static Set<String> dialects() throws IOException {
        Set<String> names = new TreeSet<>();
        for (Path dir : subdirectories(EXPECTED)) {
            names.add(dir.getFileName().toString());
        }
        names.removeAll(Set.of("kql", "iql"));
        return names;
    }

    /** Regular files below root, without dot files such as .DS_Store, which git ignores anyway. */
    private static List<Path> files(Path root) throws IOException {
        if (!Files.isDirectory(root)) {
            return List.of();
        }
        try (Stream<Path> walk = Files.walk(root)) {
            return walk.filter(Files::isRegularFile)
                    .filter(p -> !p.getFileName().toString().startsWith("."))
                    .sorted()
                    .toList();
        }
    }

    private static List<Path> subdirectories(Path dir) throws IOException {
        if (!Files.isDirectory(dir)) {
            return List.of();
        }
        try (Stream<Path> list = Files.list(dir)) {
            return list.filter(Files::isDirectory).sorted().toList();
        }
    }

    private static String strip(String name, String suffix) {
        return name.substring(0, name.length() - suffix.length());
    }

    private static String rel(Path path) {
        return CORPUS.relativize(path).toString();
    }

    private static void assertNone(String what, List<String> problems) {
        assertTrue(
                problems.isEmpty(),
                () -> problems.size() + " " + what + ":\n  " + String.join("\n  ", problems));
    }
}
