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
package ai.koryki.northwind.sqlite;

import ai.koryki.northwind.loader.Script;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Builds the Northwind database file for SQLite from the scripts in {@code db/}: tables, then the
 * data of every table, then the constraints. Run through the {@code createDatabase} task of this
 * module.
 */
public class BuildNorthwind {

    public static void main(String[] args) throws SQLException, IOException {
        if (args.length != 2) {
            throw new IllegalArgumentException(
                    "usage: BuildNorthwind <scripts directory> <database file>");
        }
        Path dir = Path.of(args[0]);
        Path database = Path.of(args[1]);
        Files.createDirectories(database.toAbsolutePath().getParent());
        Files.deleteIfExists(database);

        try (Connection connection =
                DriverManager.getConnection("jdbc:sqlite:" + database.toAbsolutePath())) {

            connection.setAutoCommit(false);

            Script.executeScript(connection, dir.resolve("tables.sql"));
            Script.executeScript(connection, dir.resolve("data_categories.sql"));
            Script.executeScript(connection, dir.resolve("data_customers.sql"));
            Script.executeScript(connection, dir.resolve("data_employees.sql"));
            Script.executeScript(connection, dir.resolve("data_employees_territories.sql"));
            Script.executeScript(connection, dir.resolve("data_order_details.sql"));
            Script.executeScript(connection, dir.resolve("data_orders.sql"));
            Script.executeScript(connection, dir.resolve("data_products.sql"));
            Script.executeScript(connection, dir.resolve("data_region.sql"));
            Script.executeScript(connection, dir.resolve("data_shippers.sql"));
            Script.executeScript(connection, dir.resolve("data_suppliers.sql"));
            Script.executeScript(connection, dir.resolve("data_territories.sql"));
            Script.executeScript(connection, dir.resolve("data_us_states.sql"));
            // self-contained (CREATE TABLE + data): the rest of this dialect's scripts are not in
            // the repo
            Script.executeScript(connection, dir.resolve("data_countries.sql"));

            Script.executeScript(connection, dir.resolve("data_check_type.sql"));
            Script.executeScript(connection, dir.resolve("data_check_temporal.sql"));
            // the complex-types test bed, self-contained like the two above
            Script.executeScript(connection, dir.resolve("data_check_complex.sql"));
            connection.commit();
        }
    }
}
