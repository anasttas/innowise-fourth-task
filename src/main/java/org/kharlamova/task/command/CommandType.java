package org.kharlamova.task.command;

import org.kharlamova.task.command.impl.*;

public enum CommandType {
    REGISTER(new RegisterCommand()),
    LOGIN(new LoginCommand()),
    LOGOUT(new LogoutCommand()),
    MAIN(new MainCommand()),
    ADMIN(new AdminCommand()),
    DELETE_USER(new DeleteUserCommand()),
    UPDATE_ROLE(new UpdateRoleCommand());
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
