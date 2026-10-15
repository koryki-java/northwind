package ai.koryki.northwind.snowflake;

import ai.koryki.northwind.loader.Connections;
import ai.koryki.northwind.loader.Script;
import java.nio.file.Path;
import java.sql.Connection;

/**
 * Creates the table of the shared-concept bed, and nothing else: {@code BuildNorthwind} drops and
 * recreates every Northwind table, which is more than a bed added later needs. Run through the
 * {@code createShared} task of this module.
 */
public class BuildShared {

    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            throw new IllegalArgumentException("usage: BuildShared <scripts directory>");
        }
        Path dir = Path.of(args[0]);

        try (Connection connection = Connections.snowflake()) {
            connection.setAutoCommit(false);
            Script.executeScript(connection, dir.resolve("data_check_shared.sql"));
            connection.commit();
        }
    }
}
