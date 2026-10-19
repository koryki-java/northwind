package ai.koryki.northwind.snowflake;

import ai.koryki.northwind.loader.Connections;
import ai.koryki.northwind.loader.Script;
import java.nio.file.Path;
import java.sql.Connection;

/**
 * Creates check_complex, the table of the complex-types bed, from its self-contained script. The rest
 * of the Northwind tables stay as they are. Run through the {@code createComplex} task of this module.
 */
public class BuildComplex {

    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            throw new IllegalArgumentException("usage: BuildComplex <scripts directory>");
        }
        Path dir = Path.of(args[0]);

        try (Connection connection = Connections.snowflake()) {
            connection.setAutoCommit(false);
            Script.executeScript(connection, dir.resolve("data_check_complex.sql"));
            connection.commit();
        }
    }
}
