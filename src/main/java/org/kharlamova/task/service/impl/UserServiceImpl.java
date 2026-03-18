package org.kharlamova.task.service.impl;

import org.kharlamova.task.dao.UserDao;
import org.kharlamova.task.dao.impl.UserDaoImpl;
import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;
import org.kharlamova.task.service.UserService;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {
    private static UserServiceImpl instance = new UserServiceImpl();

    private final UserDao userDao; // поменяй на интерфейс

    private UserServiceImpl() {
        this.userDao = new UserDaoImpl();
    }

    UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    public static UserServiceImpl getInstance() {
        return instance;
    }

    @Override
    public boolean authenticate(String email, String password) {
        boolean matches = userDao.authenticate(email, password);

        return matches;
    }

    @Override
    public boolean register(String email, String password) {
        User user = new User(email, password);

        return userDao.registerUser(user);
    }

    @Override
    public Optional<User> findUserByEmail(String email) {
        return userDao.findUserByEmail(email);
    }

    @Override
    public List<User> findAllUsers() {
        return userDao.findAllUsers();
    }

    @Override
    public boolean updateUser(Long id, Role role) {
        return userDao.updateRole(id, role);
    }

    @Override
    public boolean deleteUser(Long id) {
        return userDao.deleteUser(id);
    }
}
