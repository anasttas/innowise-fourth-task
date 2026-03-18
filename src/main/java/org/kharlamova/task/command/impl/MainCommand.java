package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.service.UserService;
import org.kharlamova.task.service.impl.UserServiceImpl;

import java.util.List;

import static org.kharlamova.task.util.Constants.*;

public class MainCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        UserService userService = UserServiceImpl.getInstance();

        String search = req.getParameter(ATTR_SEARCH);

        if (search != null && !search.isEmpty()) {
            userService.findUserByEmail(search)
                    .ifPresent(user -> req.setAttribute(ATTR_USERS, List.of(user)));
        } else {
            req.setAttribute(ATTR_USERS, userService.findAllUsers());
        }

        return PAGE_MAIN;
    }
}
