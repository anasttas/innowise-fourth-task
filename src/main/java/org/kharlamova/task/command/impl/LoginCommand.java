package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;
import org.kharlamova.task.util.Constants;

import static org.kharlamova.task.util.Constants.*;

public class LoginCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        String email = req.getParameter(PARAM_EMAIL);
        String password = req.getParameter(PARAM_PASSWORD);

        String page;

        UserService userService = UserServiceImpl.getInstance();

        if(userService.authenticate(email, password)) {
            req.setAttribute(ATTR_USER, email);

            page = PAGE_MAIN;
        } else {
            req.setAttribute(PAGE_LOGIN, MSG_INVALID);

            page = PAGE_LOGIN;
        }

        return page;
    }
}
