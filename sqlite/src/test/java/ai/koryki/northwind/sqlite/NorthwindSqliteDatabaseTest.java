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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import org.junit.jupiter.api.Test;

/**
 * The published database: the file packaged under the path koryki core reads it from holds every
 * table of the scripts, each with rows.
 */
class NorthwindSqliteDatabaseTest {

    static final String RESOURCE = "/ai/koryki/sqlite/databases/northwind/northwind.sqlite";

    private static final List<String> TABLES =
            List.of(
                    "categories",
                    "check_complex",
                    "countries",
                    "customer_customer_demo",
                    "customer_demographics",
                    "customers",
                    "employees",
                    "employee_territories",
                    "order_details",
                    "orders",
                    "products",
                    "region",
                    "shippers",
                    "suppliers",
                    "territories",
                    "us_states",
                    "check_type",
                    "check_temporal");

    /** The two tables the Northwind data leaves without rows. */
    private static final List<String> EMPTY =
            List.of("customer_customer_demo", "customer_demographics");

    @Test
    void theDatabaseIsPackagedWhereCoreLooksForIt() {
        assertNotNull(NorthwindSqliteDatabaseTest.class.getResource(RESOURCE), RESOURCE);
    }

    @Test
    void everyTableIsThereAndFilled() throws Exception {
        Path file = Files.createTempFile("northwind", ".sqlite");
        try (InputStream in = NorthwindSqliteDatabaseTest.class.getResourceAsStream(RESOURCE)) {
            Files.copy(in, file, StandardCopyOption.REPLACE_EXISTING);
        }
        try (Connection c = DriverManager.getConnection("jdbc:sqlite:" + file);
                Statement s = c.createStatement()) {
            for (String table : TABLES) {
                try (ResultSet rs = s.executeQuery("SELECT count(*) FROM " + table)) {
                    assertTrue(rs.next());
                    if (EMPTY.contains(table)) {
                        assertEquals(0, rs.getInt(1), table);
                    } else {
                        assertTrue(rs.getInt(1) > 0, table + " is empty");
                    }
                }
            }
            try (ResultSet rs =
                    s.executeQuery(
                            "SELECT count(*) FROM sqlite_master WHERE type = 'table'"
                                    + " AND name NOT LIKE 'sqlite_%'")) {
                rs.next();
                assertEquals(TABLES.size(), rs.getInt(1), "tables beyond the expected ones");
            }
        } finally {
            Files.deleteIfExists(file);
        }
    }
}
