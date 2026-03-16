package org.kharlamova.task.dao.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.kharlamova.task.dao.UserDao;
import org.kharlamova.task.entity.User;
import org.kharlamova.task.util.ConnectionManager;

import java.sql.*;
import java.util.Optional;

public class UserDaoImpl implements UserDao {
    private static final Logger logger = LogManager.getLogger();

    @Override
    public boolean authenticate(String email, String password) {
        String sql = "SELECT password FROM users WHERE email = ?";
        boolean match = false;

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                match = password.equals(rs.getString(1));
            }

        } catch (SQLException e) {
            logger.info("SQLException: " + e.getMessage());
        }

        return match;
    }

    @Override
    public boolean registerUser(User user) {
        if (findUserByEmail(user.getEmail()).isPresent()) {
            return false;
        }
        String sql = "INSERT INTO users(email, password) VALUES(?, ?)";

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getLong(1));
            }

            return true;
        } catch (SQLException e) {
            logger.info("SQLException: " + e.getMessage());

            return false;
        }
    }

    @Override
    public Optional<User> findUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();

                user.setId(rs.getLong("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));

                return Optional.of(user);
            }

        } catch (SQLException e) {
            logger.info("SQLException: " + e.getMessage());
        }

        return Optional.empty();
    }
}
