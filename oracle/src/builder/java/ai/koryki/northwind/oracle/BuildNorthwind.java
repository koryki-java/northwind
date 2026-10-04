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
package ai.koryki.northwind.oracle;

import ai.koryki.northwind.loader.Connections;
import ai.koryki.northwind.loader.Script;
import java.io.IOException;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Creates the Northwind database for Oracle from the scripts in {@code db/}: drop, tables, the data
 * of every table, then the constraints. Run through the {@code createDatabase} task of this module.
 */
public class BuildNorthwind {

    public static void main(String[] args) throws IOException, SQLException {
        if (args.length < 1) {
            throw new IllegalArgumentException("usage: BuildNorthwind <scripts directory>");
        }
        Path dir = Path.of(args[0]);

        try (Connection connection = Connections.open("oracle")) {
            connection.setAutoCommit(false);
            Script.executeScript(connection, dir.resolve("drop.sql"));

            Script.executeScript(connection, dir.resolve("tables.sql"));

            Script.executeScript(connection, dir.resolve("data_categories.sql"));
            Script.executeScript(connection, dir.resolve("data_countries.sql"));
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

            Script.executeScript(connection, dir.resolve("data_check_temporal.sql"));
            Script.executeScript(connection, dir.resolve("data_check_type.sql"));

            connection.commit();
            Script.executeScript(connection, dir.resolve("constraints.sql"));
            connection.commit();
        }
    }
}
