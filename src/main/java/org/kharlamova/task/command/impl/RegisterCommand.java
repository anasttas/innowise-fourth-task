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

        UserService userService = UserServiceImpl.getInstance();

        if (userService.register(email, password)) {
            req.setAttribute("reg_msg", "Registration successful!");

            return PAGE_MAIN;
        } else {
            req.setAttribute("reg_msg", "User with this email already exists");

            return PAGE_REGISTER;
        }
    }
}
