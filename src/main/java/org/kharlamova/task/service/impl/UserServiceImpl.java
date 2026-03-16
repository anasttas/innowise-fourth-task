package org.kharlamova.task.service.impl;

import org.kharlamova.task.dao.impl.UserDaoImpl;
import org.kharlamova.task.entity.User;
import org.kharlamova.task.service.UserService;

public class UserServiceImpl implements UserService {
    private static UserServiceImpl instance = new UserServiceImpl();

    private UserServiceImpl() {}

    public static UserServiceImpl getInstance() {
        return instance;
    }

    @Override
    public boolean authenticate(String email, String password) {
        UserDaoImpl userDao = new UserDaoImpl();

        boolean matches = userDao.authenticate(email, password);

        return matches;
    }

    @Override
    public boolean register(String email, String password) {
        UserDaoImpl userDao = new UserDaoImpl();

        User user = new User();
        user.setEmail(email);
        user.setPassword(password);

        return userDao.registerUser(user);
    }
}
