package org.kharlamova.task.pool;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public final class ConnectionPool {
    private static final Logger logger = LogManager.getLogger();

    private static final int POOL_SIZE = 8;

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres";

    private static final String USER = "postgres";

    private static final String PASSWORD = "postgres";

    private static final String DRIVER_CLASS = "org.postgresql.Driver";

    private static ConnectionPool instance;

    private BlockingQueue<Connection> free = new LinkedBlockingQueue<>(POOL_SIZE);

    static {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException e) {
            logger.error("PostgreSQL Driver not found {}", e.getMessage());
        }
    }

    public ConnectionPool() throws SQLException {
        for (int i = 0; i < POOL_SIZE; i++) {
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);

            free.add(new ProxyConnection(connection));
        }
    }

    public static ConnectionPool getInstance() {
        if (instance == null) {
            synchronized (ConnectionPool.class) {
                if (instance == null) {
                    try {
                        instance = new ConnectionPool();
                    } catch (SQLException e) {
                        logger.error("PostgreSQL connection failed {}", e.getMessage());
                    }
                }
            }
        }

        return instance;
    }

    public Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            connection = free.take();
        } catch (InterruptedException e) {
            logger.error(e.getMessage());

            Thread.currentThread().interrupt();
        }

        return connection;
    }

    public void releaseConnection(Connection connection) {
        try {
            free.put(connection);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }
}
