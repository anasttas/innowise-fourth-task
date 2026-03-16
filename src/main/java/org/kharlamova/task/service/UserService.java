package org.kharlamova.task.service;

public interface UserService {
    boolean authenticate(String email, String password);

    boolean register(String email, String password);
}
