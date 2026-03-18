package org.kharlamova.task.dao;

import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserDao {
    boolean authenticate(String email, String password);

    boolean registerUser(User user);

    Optional<User> findUserByEmail(String email);

    List<User> findAllUsers();

    boolean deleteUser(Long id);

    boolean updateRole(Long id, Role role);
}
