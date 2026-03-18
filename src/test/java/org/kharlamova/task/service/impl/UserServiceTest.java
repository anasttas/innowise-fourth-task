package org.kharlamova.task.service.impl;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.kharlamova.task.dao.UserDao;
import org.kharlamova.task.entity.Role;
import org.kharlamova.task.entity.User;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class UserServiceTest {
    private UserDao userDao;
    private UserServiceImpl userService;

    @BeforeEach
    void setUp() {
        userDao = mock(UserDao.class);
        userService = new UserServiceImpl(userDao);
    }

    @Test
    void authenticate_shouldReturnTrue_whenCredentialsCorrect() {
        when(userDao.authenticate("test@mail.ru", "pass")).thenReturn(true);

        assertTrue(userService.authenticate("test@mail.ru", "pass"));
    }

    @Test
    void authenticate_shouldReturnFalse_whenCredentialsWrong() {
        when(userDao.authenticate("test@mail.ru", "wrong")).thenReturn(false);

        assertFalse(userService.authenticate("test@mail.ru", "wrong"));
    }

    @Test
    void register_shouldReturnTrue_whenUserNew() {
        User user = new User("test@mail.ru", "pass");
        when(userDao.registerUser(user)).thenReturn(true);

        assertTrue(userService.register("test@mail.ru", "pass"));
    }

    @Test
    void register_shouldReturnFalse_whenUserExists() {
        User user = new User("test@mail.ru", "pass");
        when(userDao.registerUser(user)).thenReturn(false);

        assertFalse(userService.register("test@mail.ru", "pass"));
    }

    @Test
    void findUserByEmail_shouldReturnUser_whenExists() {
        User user = new User("test@mail.ru", "pass");
        when(userDao.findUserByEmail("test@mail.ru")).thenReturn(Optional.of(user));

        Optional<User> result = userService.findUserByEmail("test@mail.ru");

        assertTrue(result.isPresent());
        assertEquals("test@mail.ru", result.get().getEmail());
    }

    @Test
    void findUserByEmail_shouldReturnEmpty_whenNotExists() {
        when(userDao.findUserByEmail("none@mail.ru")).thenReturn(Optional.empty());

        assertTrue(userService.findUserByEmail("none@mail.ru").isEmpty());
    }

    @Test
    void findAllUsers_shouldReturnList() {
        List<User> users = List.of(new User("a@mail.ru", "pass"), new User("b@mail.ru", "pass"));
        when(userDao.findAllUsers()).thenReturn(users);

        assertEquals(2, userService.findAllUsers().size());
    }

    @Test
    void deleteUser_shouldReturnTrue_whenDeleted() {
        when(userDao.deleteUser(1L)).thenReturn(true);

        assertTrue(userService.deleteUser(1L));
    }

    @Test
    void updateUser_shouldReturnTrue_whenUpdated() {
        when(userDao.updateRole(1L, Role.ADMIN)).thenReturn(true);

        assertTrue(userService.updateUser(1L, Role.ADMIN));
    }
}
