package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;

import static org.kharlamova.task.util.Constants.ATTR_USER_ID;
import static org.kharlamova.task.util.Constants.REDIRECT_ADMIN;

public class DeleteUserCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        UserService userService = UserServiceImpl.getInstance();

        Long id = Long.parseLong(req.getParameter(ATTR_USER_ID));

        userService.deleteUser(id);

        return REDIRECT_ADMIN;
    }
}
