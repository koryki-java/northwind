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
package ai.koryki.northwind.duckdb;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * The committed {@code northwind.duckdb} is a build product of the scripts next to it; this fails
 * when the two have drifted apart, since a harness reads the file and never the scripts.
 */
class CommittedDatabaseTest {

    private static final Path DATABASE_DIR = Path.of("src/main/resources/ai/koryki/duckdb/databases/northwind");

    @Test
    void committedDatabaseMatchesItsScripts(@TempDir Path tmp) throws Exception {
        Path fresh = tmp.resolve("fresh.duckdb");
        BuildDatabase.build(DATABASE_DIR.resolve("db"), fresh);

        try (Connection connection = DriverManager.getConnection("jdbc:duckdb:" + fresh.toAbsolutePath());
             Statement statement = connection.createStatement()) {
            statement.execute("ATTACH '" + DATABASE_DIR.resolve("northwind.duckdb").toAbsolutePath()
                    + "' AS committed (READ_ONLY)");

            assertEquals(schema(statement, "fresh"), schema(statement, "committed"),
                    "tables, columns, constraints or views differ -- run ./gradlew :duckdb:updateDatabase");

            List<String> differing = new ArrayList<>();
            for (String table : strings(statement, "SELECT table_name FROM duckdb_tables() WHERE database_name = 'fresh' ORDER BY 1")) {
                String t = '"' + table.replace("\"", "\"\"") + '"';
                long onlyInScripts = count(statement, "SELECT count(*) FROM (SELECT * FROM fresh.main." + t
                        + " EXCEPT ALL SELECT * FROM committed.main." + t + ")");
                long onlyInFile = count(statement, "SELECT count(*) FROM (SELECT * FROM committed.main." + t
                        + " EXCEPT ALL SELECT * FROM fresh.main." + t + ")");
                if (onlyInScripts + onlyInFile > 0) {
                    differing.add(table + ": " + onlyInScripts + " rows only in the scripts, " + onlyInFile
                            + " only in northwind.duckdb");
                }
            }
            assertTrue(differing.isEmpty(), () -> "northwind.duckdb does not match its scripts -- run"
                    + " ./gradlew :duckdb:updateDatabase\n  " + String.join("\n  ", differing));
        }
    }

    private static List<String> schema(Statement statement, String database) throws SQLException {
        String where = "WHERE database_name = '" + database + "'";
        List<String> schema = new ArrayList<>();
        schema.addAll(strings(statement, "SELECT 'column ' || table_name || '.' || column_name || ' ' || data_type"
                + " || CASE WHEN is_nullable THEN '' ELSE ' NOT NULL' END FROM duckdb_columns() " + where
                + " ORDER BY table_name, column_index"));
        schema.addAll(strings(statement, "SELECT 'constraint ' || table_name || ' ' || constraint_text"
                + " FROM duckdb_constraints() " + where + " ORDER BY 1"));
        schema.addAll(strings(statement, "SELECT 'view ' || view_name || ' ' || sql FROM duckdb_views() "
                + where + " AND NOT internal ORDER BY 1"));
        return schema;
    }

    private static List<String> strings(Statement statement, String sql) throws SQLException {
        List<String> values = new ArrayList<>();
        try (ResultSet rs = statement.executeQuery(sql)) {
            while (rs.next()) {
                values.add(rs.getString(1));
            }
        }
        return values;
    }

    private static long count(Statement statement, String sql) throws SQLException {
        try (ResultSet rs = statement.executeQuery(sql)) {
            rs.next();
            return rs.getLong(1);
        }
    }
}
