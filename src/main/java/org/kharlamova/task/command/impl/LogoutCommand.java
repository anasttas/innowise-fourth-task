package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;

public class LogoutCommand implements Command {
    @Override
    public String execute(HttpServletRequest req) {
        return "";
    }
}
