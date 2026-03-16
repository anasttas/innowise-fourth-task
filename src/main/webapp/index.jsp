<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Вход</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            color: #1a1a1a;
        }

        .card {
            background: #fff;
            border-radius: 12px;
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 2px 16px rgba(0,0,0,.08);
        }

        .logo {
            text-align: center;
            font-size: 1.4rem;
            font-weight: 600;
            color: #1a1a1a;
            margin-bottom: 1.75rem;
        }

        .logo span { color: #4d7cff; }

        h1 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: .35rem;
        }

        .sub {
            font-size: .85rem;
            color: #888;
            margin-bottom: 1.5rem;
        }

        .field { margin-bottom: 1rem; }

        .field label {
            display: block;
            font-size: .82rem;
            font-weight: 500;
            color: #444;
            margin-bottom: .4rem;
        }

        .field input {
            width: 100%;
            padding: .65rem .9rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: inherit;
            font-size: .9rem;
            color: #1a1a1a;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

        .field input:focus {
            border-color: #4d7cff;
            box-shadow: 0 0 0 3px #4d7cff18;
        }

        .error {
            background: #fff0f3;
            border: 1px solid #ffc0cb;
            color: #c0392b;
            font-size: .82rem;
            padding: .6rem .9rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .btn-login {
            width: 100%;
            padding: .75rem;
            background: #4d7cff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-family: inherit;
            font-size: .92rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
            margin-bottom: 1rem;
        }

        .btn-login:hover { background: #3a6aee; }

        .divider {
            text-align: center;
            font-size: .8rem;
            color: #bbb;
            margin-bottom: 1rem;
            position: relative;
        }

        .divider::before, .divider::after {
            content: '';
            position: absolute;
            top: 50%; width: 42%;
            height: 1px;
            background: #eee;
        }
        .divider::before { left: 0; }
        .divider::after  { right: 0; }

        .btn-register {
            display: block;
            width: 100%;
            padding: .72rem;
            background: transparent;
            color: #4d7cff;
            border: 1.5px solid #4d7cff;
            border-radius: 8px;
            font-family: inherit;
            font-size: .92rem;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: background .2s, color .2s;
        }

        .btn-register:hover {
            background: #4d7cff;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="card">

    <h1>Вход в аккаунт</h1>
    <p class="sub">Рады видеть вас снова!</p>

    <% if (request.getAttribute("login_msg") != null) { %>
    <div class="error">${login_msg}</div>
    <% } %>

    <form action="controller">
        <input type="hidden" name="command" value="login"/>

        <div class="field">
            <label for="email">Email</label>
            <input type="text" id="email" name="email" placeholder="example@mail.ru"/>
        </div>

        <div class="field">
            <label for="pass">Пароль</label>
            <input type="password" id="pass" name="pass" placeholder="Введите пароль"/>
        </div>

        <button type="submit" class="btn-login" name="sub">Войти</button>
    </form>

    <div class="divider">или</div>

    <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn-register">Зарегистрироваться</a>
</div>

</body>
</html>