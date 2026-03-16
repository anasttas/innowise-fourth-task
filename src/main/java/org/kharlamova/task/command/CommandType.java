package org.kharlamova.task.command;

import org.kharlamova.task.command.impl.RegisterCommand;
import org.kharlamova.task.command.impl.DefaultCommand;
import org.kharlamova.task.command.impl.LoginCommand;
import org.kharlamova.task.command.impl.LogoutCommand;

public enum CommandType {
    REGISTER(new RegisterCommand()),
    LOGIN(new LoginCommand()),
    LOGOUT(new LogoutCommand()),
    DEFAULT(new DefaultCommand());
    Command command;

    CommandType(Command command) {
        this.command = command;
    }

    public Command getCommand() {
        return command;
    }

    public static Command define(String commandStr){
        CommandType current = CommandType.valueOf(commandStr.toUpperCase());

        return current.command;
    }
}
