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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Builds the Northwind DuckDB database from the scripts: {@code tables.sql} first, then every
 * {@code data_*.sql}. Run through the {@code buildDatabase} and {@code updateDatabase} tasks.
 */
public final class BuildDatabase {

    private BuildDatabase() {
    }

    /** {@code <scripts directory> <database file>} */
    public static void main(String[] args) throws IOException, SQLException {
        if (args.length != 2) {
            throw new IllegalArgumentException("usage: BuildDatabase <scripts directory> <database file>");
        }
        build(Path.of(args[0]), Path.of(args[1]));
    }

    public static void build(Path scripts, Path database) throws IOException, SQLException {
        // DuckDB would open an existing file and fail on the first CREATE TABLE.
        Files.deleteIfExists(database);
        Files.deleteIfExists(Path.of(database + ".wal"));
        Files.createDirectories(database.toAbsolutePath().getParent());

        try (Connection connection = DriverManager.getConnection("jdbc:duckdb:" + database.toAbsolutePath());
             Statement statement = connection.createStatement()) {
            connection.setAutoCommit(false);
            // The driver runs a whole script per call, parsed by DuckDB itself.
            for (Path script : scripts(scripts)) {
                statement.execute(Files.readString(script));
            }
            connection.commit();
        }
    }

    static List<Path> scripts(Path directory) throws IOException {
        List<Path> scripts = new ArrayList<>();
        scripts.add(directory.resolve("tables.sql"));
        try (Stream<Path> files = Files.list(directory)) {
            files.filter(p -> p.getFileName().toString().matches("data_.*\\.sql"))
                    .sorted()
                    .forEach(scripts::add);
        }
        return scripts;
    }
}
