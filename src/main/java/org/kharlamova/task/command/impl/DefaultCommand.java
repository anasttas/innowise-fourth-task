package org.kharlamova.task.command.impl;

import jakarta.servlet.http.HttpServletRequest;
import org.kharlamova.task.command.Command;

public class DefaultCommand implements Command {
    private final static String PAGE_NAME = "index.jsp";

    @Override
    public String execute(HttpServletRequest req) {
        return PAGE_NAME;
    }
}
