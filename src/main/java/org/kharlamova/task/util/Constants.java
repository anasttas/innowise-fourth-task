package org.kharlamova.task.util;

public final class Constants {
    public static final String PARAM_EMAIL = "email";
    public static final String PARAM_PASSWORD = "pass";
    public static final String PARAM_REPEAT_PASSWORD = "pass2";

    public static final String COLUMN_ID = "id";
    public static final String COLUMN_PASSWORD  = "password";
    public static final String COLUMN_EMAIL = "email";
    public static final String COLUMN_ROLE = "role";

    public static final String PAGE_MAIN = "pages/main.jsp";
    public static final String PAGE_LOGIN = "index.jsp";
    public static final String PAGE_REGISTER = "pages/register.jsp";
    public static final String PAGE_ADMIN = "pages/admin.jsp";
    public static final String REDIRECT_MAIN = "redirect:controller?command=main";
    public static final String REDIRECT_ADMIN = "redirect:controller?command=admin";

    public static final String ATTR_USER = "user";
    public static final String ATTR_USERS = "users";
    public static final String ATTR_SEARCH = "search";
    public static final String ATTR_LOGIN_MSG = "login_msg";
    public static final String ATTR_REGISTER = "register_error";
    public static final String ATTR_USER_ID = "userId";
    public static final String ATTR_USER_ROLE = "role";

    public static final String MSG_INVALID = "Invalid email or password";
    public static final String MSG_WRONG_PASSWORD = "The passwords do not match";
    public static final String MSG_WRONG_EMAIL = "User with this email already exists";
}
