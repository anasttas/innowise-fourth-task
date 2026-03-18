<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Админ панель</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap');

        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f5f5f5;
            min-height: 100vh;
            color: #1a1a1a;
            padding: 2rem 1rem;
        }

        .container { width: 100%; max-width: 760px; margin: 0 auto; }

        .header {
            background: #fff;
            border-radius: 12px;
            padding: 1.25rem 1.75rem;
            box-shadow: 0 2px 16px rgba(0,0,0,.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.25rem;
        }

        .welcome { font-size: .85rem; color: #888; }
        .welcome strong { color: #1a1a1a; font-weight: 600; }

        .btn-logout {
            padding: .5rem 1.1rem;
            background: transparent;
            color: #c0392b;
            border: 1.5px solid #c0392b;
            border-radius: 8px;
            font-family: inherit;
            font-size: .82rem;
            font-weight: 600;
            text-decoration: none;
            transition: background .2s, color .2s;
        }
        .btn-logout:hover { background: #c0392b; color: #fff; }

        .card {
            background: #fff;
            border-radius: 12px;
            padding: 1.5rem 1.75rem;
            box-shadow: 0 2px 16px rgba(0,0,0,.08);
            margin-bottom: 1.25rem;
        }

        .card-title { font-size: 1rem; font-weight: 600; margin-bottom: 1rem; }

        .search-row { display: flex; gap: .75rem; }

        .search-row input {
            flex: 1;
            padding: .65rem .9rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: inherit;
            font-size: .9rem;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        .search-row input:focus {
            border-color: #4d7cff;
            box-shadow: 0 0 0 3px #4d7cff18;
        }

        .btn-search {
            padding: .65rem 1.3rem;
            background: #4d7cff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-family: inherit;
            font-size: .9rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
        }
        .btn-search:hover { background: #3a6aee; }

        .btn-reset {
            padding: .65rem 1rem;
            background: transparent;
            color: #888;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-family: inherit;
            font-size: .9rem;
            text-decoration: none;
            transition: border-color .2s, color .2s;
        }
        .btn-reset:hover { border-color: #aaa; color: #444; }

        .users-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .badge {
            background: #f0f4ff;
            color: #4d7cff;
            font-size: .75rem;
            font-weight: 600;
            padding: .25rem .65rem;
            border-radius: 20px;
        }

        .user-list { display: flex; flex-direction: column; gap: .6rem; }

        .user-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: .9rem 1rem;
            border: 1px solid #eee;
            border-radius: 10px;
            gap: .75rem;
            transition: border-color .2s, box-shadow .2s;
        }
        .user-item:hover {
            border-color: #4d7cff44;
            box-shadow: 0 2px 8px rgba(77,124,255,.08);
        }

        .user-left { display: flex; align-items: center; gap: .85rem; flex: 1; min-width: 0; }

        .avatar {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: #f0f4ff;
            color: #4d7cff;
            font-size: .82rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            text-transform: uppercase;
            flex-shrink: 0;
        }

        .user-email { font-size: .88rem; font-weight: 500; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .user-id { font-size: .75rem; color: #bbb; margin-top: .15rem; }

        .user-actions { display: flex; align-items: center; gap: .5rem; flex-shrink: 0; }

        /* Role select */
        .role-select {
            padding: .3rem .5rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: inherit;
            font-size: .78rem;
            font-weight: 600;
            cursor: pointer;
            outline: none;
            transition: border-color .2s;
        }
        .role-select:focus { border-color: #4d7cff; }

        .btn-update {
            padding: .3rem .75rem;
            background: #4d7cff;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-family: inherit;
            font-size: .78rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
        }
        .btn-update:hover { background: #3a6aee; }

        .btn-delete {
            padding: .3rem .75rem;
            background: transparent;
            color: #c0392b;
            border: 1.5px solid #c0392b;
            border-radius: 6px;
            font-family: inherit;
            font-size: .78rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s, color .2s;
        }
        .btn-delete:hover { background: #c0392b; color: #fff; }

        .empty { text-align: center; padding: 2.5rem 0; color: #bbb; font-size: .9rem; }
        .empty-icon { font-size: 2rem; margin-bottom: .5rem; }

        .info-msg {
            background: #f0f4ff;
            border: 1px solid #c5d5ff;
            color: #3a5fcc;
            font-size: .82rem;
            padding: .6rem .9rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
<div class="container">

    <div class="header">
        <div class="welcome">Привет, <strong>${user}</strong>! 🛡️ Админ</div>
        <a href="${pageContext.request.contextPath}/controller?command=logout" class="btn-logout">Выйти</a>
    </div>

    <div class="card">
        <div class="card-title">Поиск пользователя</div>
        <form action="${pageContext.request.contextPath}/controller" method="get">
            <input type="hidden" name="command" value="admin"/>
            <div class="search-row">
                <input type="text" name="search" placeholder="Поиск по email..." value="${param.search}"/>
                <button type="submit" class="btn-search">Найти</button>
                <a href="${pageContext.request.contextPath}/controller?command=admin" class="btn-reset">Сбросить</a>
            </div>
        </form>
    </div>

    <div class="card">
        <div class="users-header">
            <div class="card-title" style="margin-bottom:0">Пользователи</div>
            <span class="badge">${users.size()} чел.</span>
        </div>

        <c:if test="${param.search != null && param.search != ''}">
            <div class="info-msg">Результаты поиска: <strong>${param.search}</strong></div>
        </c:if>

        <div class="user-list">
            <c:choose>
                <c:when test="${empty users}">
                    <div class="empty">
                        <div class="empty-icon">🔍</div>
                        Пользователи не найдены
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="u" items="${users}">
                        <div class="user-item">
                            <div class="user-left">
                                <div class="avatar">${u.email.substring(0,1)}</div>
                                <div>
                                    <div class="user-email">${u.email}</div>
                                    <div class="user-id">#${u.id}</div>
                                </div>
                            </div>

                            <div class="user-actions">
                                <!-- Смена роли -->
                                <form action="${pageContext.request.contextPath}/controller" method="post">
                                    <input type="hidden" name="command" value="update_role"/>
                                    <input type="hidden" name="userId" value="${u.id}"/>
                                    <select name="role" class="role-select">
                                        <option value="USER"  ${u.role == 'USER'  ? 'selected' : ''}>USER</option>
                                        <option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                                    </select>
                                    <button type="submit" class="btn-update">Сохранить</button>
                                </form>

                                <!-- Удаление -->
                                <form action="${pageContext.request.contextPath}/controller" method="post">
                                    <input type="hidden" name="command" value="delete_user"/>
                                    <input type="hidden" name="userId" value="${u.id}"/>
                                    <button type="submit" class="btn-delete">Удалить</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>
</body>
</html>