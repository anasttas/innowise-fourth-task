package org.kharlamova.task.dao.impl;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.kharlamova.task.dao.UserDao;
import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;
import org.kharlamova.task.pool.ConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.kharlamova.task.util.Constants.*;

public class UserDaoImpl implements UserDao {
    private static final Logger logger = LogManager.getLogger();

    private static final String FIND_PASSWORD_BY_EMAIL = "SELECT password FROM users WHERE email = ?";

    private static final String FIND_BY_EMAIL = "SELECT * FROM users WHERE email = ?";

    private static final String INSERT_USER = "INSERT INTO users(email, password, role) VALUES(?, ?, ?)";

    private static final String FIND_ALL_USERS = "SELECT * FROM users";

    private static final String DELETE_USER = "DELETE FROM users WHERE id = ?";

    private static final String UPDATE_PASSWORD = "UPDATE users SET role = ? WHERE id = ?";

    @Override
    public boolean authenticate(String email, String password) {
        boolean match = false;

        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(FIND_PASSWORD_BY_EMAIL)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                match = password.equals(rs.getString(1));
            }

        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());
        }

        return match;
    }

    @Override
    public boolean registerUser(User user) {
        if (findUserByEmail(user.getEmail()).isPresent()) {
            return false;
        }

        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole().toString());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getLong(1));
            }

            return true;
        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());

            return false;
        }
    }

    @Override
    public Optional<User> findUserByEmail(String email) {
        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(FIND_BY_EMAIL)) {

            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();

                user.setId(rs.getLong(COLUMN_ID));
                user.setEmail(rs.getString(COLUMN_EMAIL));
                user.setPassword(rs.getString(COLUMN_PASSWORD));
                user.setRole(Role.valueOf(rs.getString(COLUMN_ROLE)));

                return Optional.of(user);
            }

        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());
        }

        return Optional.empty();
    }

    @Override
    public List<User> findAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(FIND_ALL_USERS)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                User user = new User();

                user.setId(rs.getLong(COLUMN_ID));
                user.setEmail(rs.getString(COLUMN_EMAIL));
                user.setPassword(rs.getString(COLUMN_PASSWORD));
                user.setRole(Role.valueOf(rs.getString(COLUMN_ROLE)));

                users.add(user);
            }

        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());
        }

        return users;
    }

    @Override
    public boolean deleteUser(Long id) {
        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_USER)) {

            ps.setLong(1, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());

            return false;
        }
    }

    @Override
    public boolean updateRole(Long id, Role role) {
        try (Connection conn = ConnectionPool.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_PASSWORD)) {

            ps.setString(1, role.name());
            ps.setLong(2, id);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("SQLException: " + e.getMessage());

            return false;
        }
    }
}
