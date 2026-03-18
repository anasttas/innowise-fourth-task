package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;

import static org.kharlamova.task.util.Constants.*;

public class LoginCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        String email = req.getParameter(PARAM_EMAIL);
        String password = req.getParameter(PARAM_PASSWORD);

        String page;

        UserService userService = UserServiceImpl.getInstance();

        if(userService.authenticate(email, password)) {
            User user = userService.findUserByEmail(email).get();

            req.getSession().setAttribute(ATTR_USER, email);
            return user.getRole() == Role.ADMIN ? REDIRECT_ADMIN : REDIRECT_MAIN;
        } else {
            req.setAttribute(ATTR_LOGIN_MSG, MSG_INVALID);

            page = PAGE_LOGIN;
        }

        return page;
    }
}
