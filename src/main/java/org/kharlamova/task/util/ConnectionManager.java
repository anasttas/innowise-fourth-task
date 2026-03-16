package org.kharlamova.task.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class ConnectionManager {
    private static final Logger logger = LogManager.getLogger();

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres";

    private static final String USER = "postgres";

    private static final String PASSWORD = "postgres";


    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            logger.info("PostgreSQL Driver not found {}", e.getMessage());
        }
    }

    private ConnectionManager() {}

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
