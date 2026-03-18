package org.kharlamova.task.service;

import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    boolean authenticate(String email, String password);

    boolean register(String email, String password);

    Optional<User> findUserByEmail(String email);

    List<User> findAllUsers();

    boolean updateUser(Long id, Role role);

    boolean deleteUser(Long id);
}
