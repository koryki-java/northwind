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
package ai.koryki.northwind.loader;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;

/** Cutting a script into statements, and that every script of every dialect module can be cut. */
class ScriptTest {

    private static final List<String> DIALECTS =
            List.of("postgresql", "mariadb", "oracle", "mssql", "snowflake", "sqlite");

    @Test
    void statementsAreCutAtSemicolons() {
        assertEquals(
                List.of("CREATE TABLE a (x INT)", "INSERT INTO a VALUES (1)"),
                Script.splitStatements("CREATE TABLE a (x INT); INSERT INTO a VALUES (1);"));
    }

    @Test
    void commentsAreDropped() {
        assertEquals(
                List.of("SELECT 1"),
                Script.splitStatements(
                        "-- a; comment\n# mysql; comment\n/* block; */ SELECT 1; -- trailing"));
    }

    @Test
    void semicolonsInsideQuotesStay() {
        assertEquals(
                List.of("INSERT INTO t VALUES ('a;b', \"c;d\", `e;f`, 'it''s')"),
                Script.splitStatements("INSERT INTO t VALUES ('a;b', \"c;d\", `e;f`, 'it''s');"));
    }

    @Test
    void dollarQuotedBodiesAreOneStatement() {
        List<String> statements =
                Script.splitStatements(
                        "CREATE FUNCTION f() RETURNS int AS $body$ SELECT 1; SELECT 2; $body$"
                                + " LANGUAGE sql; SELECT 3;");

        assertEquals(2, statements.size());
        assertTrue(statements.get(0).contains("SELECT 1; SELECT 2;"), statements.get(0));
    }

    @Test
    void aScriptWithoutAFinalSemicolonKeepsItsLastStatement() {
        assertEquals(List.of("SELECT 1", "SELECT 2"), Script.splitStatements("SELECT 1; SELECT 2"));
    }

    @Test
    void everyScriptOfEveryDialectIsCutIntoStatements() throws IOException {
        int scripts = 0;
        for (String dialect : DIALECTS) {
            Path db =
                    Path.of(
                            "..",
                            dialect,
                            "src/main/resources/ai/koryki",
                            dialect,
                            "databases/northwind/db");
            assertTrue(Files.isDirectory(db), "missing " + db);
            try (Stream<Path> files = Files.list(db)) {
                for (Path script :
                        (Iterable<Path>)
                                files.filter(p -> p.toString().endsWith(".sql")).sorted()
                                        ::iterator) {
                    List<String> statements = Script.statements(script);
                    assertFalse(statements.isEmpty(), script + " has no statement");
                    for (String s : statements) {
                        assertFalse(s.isBlank(), script + " has a blank statement");
                    }
                    scripts++;
                }
            }
        }
        // 18 each for postgresql, mariadb, oracle, mssql; 4 for snowflake; 16 for sqlite
        assertEquals(18 * 4 + 4 + 16, scripts);
    }
}
