package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;

import static org.kharlamova.task.util.Constants.*;

public class RegisterCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        String email = req.getParameter(PARAM_EMAIL);

        String password = req.getParameter(PARAM_PASSWORD);

        String repeatPassword = req.getParameter(PARAM_REPEAT_PASSWORD);

        if(!password.equals(repeatPassword)) {
            req.setAttribute(ATTR_REGISTER, MSG_WRONG_PASSWORD);

            return PAGE_REGISTER;
        }

        UserService userService = UserServiceImpl.getInstance();

        if (userService.register(email, password)) {
            req.getSession().setAttribute(ATTR_USER, email);

            return REDIRECT_MAIN;
        } else {
            req.setAttribute(ATTR_REGISTER, MSG_WRONG_EMAIL);

            return PAGE_REGISTER;
        }
    }
}
