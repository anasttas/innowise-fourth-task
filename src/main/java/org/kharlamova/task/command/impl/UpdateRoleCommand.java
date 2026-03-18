package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.entity.Role;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;

import static org.kharlamova.task.util.Constants.*;

public class UpdateRoleCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        Long id = Long.parseLong(req.getParameter(ATTR_USER_ID));

        Role role = Role.valueOf(req.getParameter(ATTR_USER_ROLE));

        UserService userService = UserServiceImpl.getInstance();

        userService.updateUser(id, role);

        return REDIRECT_ADMIN;
    }
}
