<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>404 — Not Found</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;700&display=swap');

        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}

        :root{
            --bg:#080810;
            --panel:#0d0d1a;
            --border:#1e1e35;
            --accent:#4d7cff;
            --accent-dim:#4d7cff22;
            --accent-glow:#4d7cff44;
            --text:#c8cce8;
            --muted:#3d4060;
            --bright:#e8eaff;
            --font:'IBM Plex Mono',monospace;
        }

        html,body{height:100%}

        body{
            background:var(--bg);
            color:var(--text);
            font-family:var(--font);
            display:grid;
            grid-template-rows:auto 1fr auto;
            min-height:100vh;
            overflow:hidden;
            position:relative;
        }

        /* Точечная сетка */
        body::before{
            content:'';
            position:fixed;inset:0;
            background-image:radial-gradient(circle, #1e1e35 1px, transparent 1px);
            background-size:28px 28px;
            pointer-events:none;
            opacity:.6;
        }

        /* Акцентный луч сверху */
        body::after{
            content:'';
            position:fixed;
            top:0;left:50%;
            transform:translateX(-50%);
            width:600px;height:2px;
            background:linear-gradient(90deg,transparent,var(--accent),transparent);
            box-shadow:0 0 40px 10px var(--accent-glow);
        }

        /* ── TOPBAR ── */
        .topbar{
            display:flex;align-items:center;justify-content:space-between;
            padding:.85rem 2rem;
            border-bottom:1px solid var(--border);
            position:relative;z-index:10;
            animation:fadein .4s ease both;
        }

        .topbar-left{display:flex;align-items:center;gap:.75rem}

        .logo{
            font-size:.7rem;font-weight:700;
            letter-spacing:.2em;text-transform:uppercase;
            color:var(--accent);
        }

        .sep{color:var(--border);font-size:.9rem}

        .breadcrumb{font-size:.65rem;color:var(--muted);letter-spacing:.08em}
        .breadcrumb span{color:var(--text)}

        .topbar-right{
            font-size:.62rem;color:var(--muted);
            letter-spacing:.06em;
        }

        /* ── MAIN ── */
        main{
            display:flex;align-items:center;justify-content:center;
            padding:2rem;position:relative;z-index:10;
        }

        .card{
            width:100%;max-width:700px;
            border:1px solid var(--border);
            background:var(--panel);
            position:relative;
        }

        /* Угловые засечки */
        .card::before,.card::after{
            content:'';position:absolute;
            width:12px;height:12px;
            border-color:var(--accent);border-style:solid;
        }
        .card::before{top:-1px;left:-1px;border-width:2px 0 0 2px}
        .card::after{bottom:-1px;right:-1px;border-width:0 2px 2px 0}

        .card-header{
            display:flex;align-items:center;justify-content:space-between;
            padding:.6rem 1.25rem;
            border-bottom:1px solid var(--border);
            background:#0a0a16;
        }

        .card-title{
            font-size:.62rem;letter-spacing:.15em;
            text-transform:uppercase;color:var(--muted);
            display:flex;align-items:center;gap:.5rem;
        }

        .card-title::before{
            content:'';width:6px;height:6px;
            background:var(--accent);border-radius:50%;
            box-shadow:0 0 8px var(--accent);
            animation:blink 2s step-end infinite;
        }

        .card-code{
            font-size:.6rem;letter-spacing:.1em;
            color:var(--accent);opacity:.6;
        }

        .card-body{padding:2.5rem 2rem 2rem}

        .error-number{
            font-size:clamp(5rem,15vw,9rem);
            font-weight:700;line-height:1;
            color:var(--bright);
            letter-spacing:-.02em;
            position:relative;
            display:inline-block;
            animation:slideup .5s .15s cubic-bezier(.16,1,.3,1) both;
        }

        .error-number::after{
            content:attr(data-n);
            position:absolute;top:0;left:0;
            color:var(--accent);
            clip-path:polygon(0 45%,100% 45%,100% 55%,0 55%);
            animation:scanline 5s 2s infinite;
        }

        @keyframes scanline{
            0%,90%,100%{transform:translate(0);opacity:0}
            92%{transform:translate(-4px,0);opacity:.7}
            94%{transform:translate(4px,0);opacity:.7}
            96%{transform:translate(0);opacity:0}
        }

        .error-label{
            font-size:.72rem;font-weight:700;
            letter-spacing:.25em;text-transform:uppercase;
            color:var(--accent);margin:.5rem 0 1.5rem;
            animation:slideup .5s .25s cubic-bezier(.16,1,.3,1) both;
        }

        .divider{
            height:1px;
            background:linear-gradient(90deg,var(--accent),transparent);
            margin-bottom:1.5rem;
            animation:slideup .5s .3s both;
        }

        .message{
            font-size:.78rem;line-height:1.85;
            color:var(--text);margin-bottom:.75rem;
            animation:slideup .5s .35s both;
        }

        .uri-line{
            font-size:.7rem;color:var(--muted);
            margin-bottom:2.5rem;
            animation:slideup .5s .4s both;
        }

        .uri-line code{
            color:var(--accent);
            background:var(--accent-dim);
            padding:.15em .5em;border-radius:2px;
        }

        .actions{
            display:flex;gap:.75rem;flex-wrap:wrap;
            animation:slideup .5s .45s both;
        }

        .btn{
            display:inline-flex;align-items:center;gap:.5rem;
            padding:.65rem 1.4rem;
            font-family:var(--font);font-size:.68rem;
            font-weight:700;letter-spacing:.1em;text-transform:uppercase;
            text-decoration:none;cursor:pointer;border:none;
            position:relative;overflow:hidden;transition:color .2s;
        }

        .btn-primary{
            background:var(--accent);color:#080810;
        }
        .btn-primary:hover{filter:brightness(1.2)}

        .btn-ghost{
            background:transparent;color:var(--text);
            border:1px solid var(--border);
        }
        .btn-ghost::before{
            content:'';position:absolute;inset:0;
            background:var(--accent-dim);
            transform:translateX(-101%);
            transition:transform .2s cubic-bezier(.4,0,.2,1);
        }
        .btn-ghost:hover::before{transform:translateX(0)}
        .btn-ghost:hover{border-color:var(--accent);color:var(--bright)}
        .btn-ghost span,.btn-ghost svg{position:relative;z-index:1}

        /* ── BOTTOMBAR ── */
        .bottombar{
            display:flex;align-items:center;justify-content:space-between;
            padding:.75rem 2rem;
            border-top:1px solid var(--border);
            font-size:.6rem;color:var(--muted);
            letter-spacing:.07em;
            position:relative;z-index:10;
            animation:fadein .4s .6s both;
        }

        .status-pill{
            display:flex;align-items:center;gap:.4rem;
            font-size:.6rem;
            color:var(--accent);
        }
        .status-pill::before{
            content:'';width:5px;height:5px;
            background:var(--accent);border-radius:50%;
        }

        /* ── ANIMATIONS ── */
        @keyframes fadein{from{opacity:0}to{opacity:1}}
        @keyframes slideup{
            from{opacity:0;transform:translateY(14px)}
            to{opacity:1;transform:translateY(0)}
        }
        @keyframes blink{
            0%,100%{opacity:1}50%{opacity:.2}
        }
    </style>
</head>
<body>

<nav class="topbar">
    <div class="topbar-left">
        <span class="logo">System</span>
        <span class="sep">/</span>
        <span class="breadcrumb">error <span>› 404</span></span>
    </div>
    <div class="topbar-right"><%= new java.util.Date() %></div>
</nav>

<main>
    <div class="card">
        <div class="card-header">
            <span class="card-title">HTTP Response</span>
            <span class="card-code">ERR_NOT_FOUND</span>
        </div>
        <div class="card-body">
            <div class="error-number" data-n="404">404</div>
            <div class="error-label">Page Not Found</div>
            <div class="divider"></div>
            <p class="message">Запрошенный ресурс не существует на этом сервере.<br>Возможно, страница была удалена или адрес введён неверно.</p>
            <p class="uri-line">Запрос: <code><%= request.getRequestURI() %></code></p>
            <div class="actions">
                <a href="/" class="btn btn-primary">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M3 9l9-7 9 7v11a2 2 0 01-2 2H5a2 2 0 01-2-2z"/></svg>
                    На главную
                </a>
                <a href="javascript:history.back()" class="btn btn-ghost">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
                    <span>Назад</span>
                </a>
            </div>
        </div>
    </div>
</main>

<footer class="bottombar">
    <span><%= request.getServerName() %> · HTTP/1.1</span>
    <span class="status-pill">404 Not Found</span>
</footer>

</body>
</html>