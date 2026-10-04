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

import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Properties;

/**
 * The connection a database builder loads into, from the same system properties the test suites of
 * koryki core use: {@code <dialect>.northwind.url}, {@code .user} and {@code .password}, which the
 * Gradle tasks of the dialect modules hand over from {@code ~/.gradle/gradle.properties}.
 */
public final class Connections {

    private Connections() {}

    /** The database of {@code dialect}: postgresql, mariadb, oracle, mssql. */
    public static Connection open(String dialect) throws SQLException {
        Properties props = new Properties();
        props.setProperty("user", required(dialect + ".northwind.user"));
        props.setProperty("password", required(dialect + ".northwind.password"));
        return DriverManager.getConnection(required(dialect + ".northwind.url"), props);
    }

    /** Snowflake signs in with a key pair, not a password: {@code snowflake.privatekey}. */
    public static Connection snowflake() throws Exception {
        Properties props = new Properties();
        props.setProperty("user", required("snowflake.northwind.user"));
        props.put("privateKey", privateKey(System.getProperty("snowflake.privatekey")));
        return DriverManager.getConnection(required("snowflake.northwind.url"), props);
    }

    private static String required(String property) {
        String value = System.getProperty(property);
        // Gradle passes an empty value through when the property is commented out
        if (value == null || value.isBlank()) {
            throw new IllegalStateException(
                    property
                            + " is not set. Put it in ~/.gradle/gradle.properties or pass"
                            + " -P"
                            + property
                            + "=... to Gradle.");
        }
        return value;
    }

    static PrivateKey privateKey(String filename) throws Exception {
        if (filename == null || filename.isBlank()) {
            throw new IllegalArgumentException(
                    "snowflake.privatekey is not set; it must be the path to the PEM private key."
                            + " Set it in gradle.properties or pass -Psnowflake.privatekey=/path/key.p8");
        }
        String key = Files.readString(Paths.get(filename));
        key =
                key.replace("-----BEGIN PRIVATE KEY-----", "")
                        .replace("-----END PRIVATE KEY-----", "")
                        .replaceAll("\\s", "");
        byte[] decoded = Base64.getDecoder().decode(key);
        return KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(decoded));
    }
}
