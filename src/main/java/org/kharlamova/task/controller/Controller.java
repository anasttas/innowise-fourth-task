package org.kharlamova.task.controller;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.kharlamova.task.command.Command;
import org.kharlamova.task.command.CommandType;

@WebServlet(name = "helloServlet", urlPatterns = {"/controller", "*.do"})
public class Controller extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html";

    private static final String PARAM_COMMAND = "command";

    private static final String REDIRECT_PREFIX = "redirect:";

    public void init() {
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    public void destroy() {
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType(CONTENT_TYPE);

        String commandStr = req.getParameter(PARAM_COMMAND);
        Command command = CommandType.define(commandStr);

        String page = command.execute(req);

        if (page.startsWith(REDIRECT_PREFIX)) {
            resp.sendRedirect(req.getContextPath() + "/" + page.substring(REDIRECT_PREFIX.length()));
        } else {
            req.getRequestDispatcher(page).forward(req, resp);
        }
    }
}