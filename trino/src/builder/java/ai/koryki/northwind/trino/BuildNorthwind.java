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
package ai.koryki.northwind.trino;

import ai.koryki.northwind.loader.Connections;
import ai.koryki.northwind.loader.Script;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Creates the complex-types table in the memory catalog of Trino from the script in {@code db/}.
 * Run through the {@code createDatabase} task of this module.
 */
public class BuildNorthwind {

    public static void main(String[] args) throws IOException, SQLException {
        if (args.length < 1) {
            throw new IllegalArgumentException("usage: BuildNorthwind <scripts directory>");
        }
        Path dir = Path.of(args[0]);

        try (Connection connection = Connections.trinoMemory()) {
            Script.executeScript(connection, dir.resolve("data_check_complex.sql"));
        }
    }
}
