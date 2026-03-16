<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>500 — Internal Server Error</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;700&display=swap');

        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}

        :root{
            --bg:#100808;
            --panel:#160d0d;
            --border:#2a1a1a;
            --accent:#ff4444;
            --accent-dim:#ff444422;
            --accent-glow:#ff444433;
            --text:#e8c8c8;
            --muted:#5a3030;
            --bright:#ffe8e8;
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

        body::before{
            content:'';
            position:fixed;inset:0;
            background-image:radial-gradient(circle,#2a1a1a 1px,transparent 1px);
            background-size:28px 28px;
            pointer-events:none;
            opacity:.6;
        }

        body::after{
            content:'';
            position:fixed;
            top:0;left:50%;
            transform:translateX(-50%);
            width:600px;height:2px;
            background:linear-gradient(90deg,transparent,var(--accent),transparent);
            box-shadow:0 0 40px 10px var(--accent-glow);
        }

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

        .topbar-right{font-size:.62rem;color:var(--muted);letter-spacing:.06em}

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
            background:#120a0a;
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
            animation:blink 1.2s step-end infinite;
        }

        .card-code{font-size:.6rem;letter-spacing:.1em;color:var(--accent);opacity:.6}

        .card-body{padding:2rem 2rem 2rem}

        .error-number{
            font-size:clamp(5rem,15vw,9rem);
            font-weight:700;line-height:1;
            color:var(--bright);
            letter-spacing:-.02em;
            display:inline-block;
            animation:slideup .5s .15s cubic-bezier(.16,1,.3,1) both;
        }

        .error-number::after{
            content:attr(data-n);
            position:absolute;top:0;left:0;
            color:var(--accent);
            clip-path:polygon(0 45%,100% 45%,100% 55%,0 55%);
            animation:scanline 3.5s 1s infinite;
        }

        .error-number{position:relative}

        @keyframes scanline{
            0%,85%,100%{transform:translate(0);opacity:0}
            87%{transform:translate(-5px,0);opacity:.8}
            89%{transform:translate(5px,0);opacity:.8}
            91%{transform:translate(-2px,0);opacity:.5}
            93%{transform:translate(0);opacity:0}
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
            color:var(--text);margin-bottom:1.5rem;
            animation:slideup .5s .35s both;
        }

        /* Стектрейс */
        .trace{
            border:1px solid var(--border);
            background:#0e0808;
            margin-bottom:2rem;
            animation:slideup .5s .4s both;
        }

        .trace-header{
            display:flex;align-items:center;justify-content:space-between;
            padding:.4rem .9rem;
            border-bottom:1px solid var(--border);
            font-size:.58rem;letter-spacing:.12em;
            text-transform:uppercase;
        }

        .trace-header-left{color:var(--muted)}
        .trace-exception{color:var(--accent);font-size:.62rem;word-break:break-all}

        .trace-body{padding:.85rem .9rem}

        .exc-type{color:var(--accent);font-size:.72rem;font-weight:700;margin-bottom:.3rem;word-break:break-all}
        .exc-msg{color:var(--text);font-size:.68rem;opacity:.8;margin-bottom:.8rem;line-height:1.6}

        .trace-lines{list-style:none;border-top:1px solid var(--border);padding-top:.7rem}
        .trace-lines li{
            font-size:.63rem;color:var(--muted);
            line-height:2;padding-left:.9rem;position:relative;
        }
        .trace-lines li::before{content:'at ';position:absolute;left:0;color:#3a1818}
        .trace-lines li .cls{color:#a07070}
        .trace-lines li .mth{color:var(--text)}
        .trace-lines li .ref{color:var(--accent);opacity:.5}
        .no-trace{font-size:.7rem;color:var(--muted);font-style:italic}

        .actions{
            display:flex;gap:.75rem;flex-wrap:wrap;
            animation:slideup .5s .5s both;
        }

        .btn{
            display:inline-flex;align-items:center;gap:.5rem;
            padding:.65rem 1.4rem;
            font-family:var(--font);font-size:.68rem;
            font-weight:700;letter-spacing:.1em;text-transform:uppercase;
            text-decoration:none;cursor:pointer;border:none;
            position:relative;overflow:hidden;transition:color .2s;
        }

        .btn-primary{background:var(--accent);color:#100808}
        .btn-primary:hover{filter:brightness(1.15)}

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

        .bottombar{
            display:flex;align-items:center;justify-content:space-between;
            padding:.75rem 2rem;
            border-top:1px solid var(--border);
            font-size:.6rem;color:var(--muted);
            letter-spacing:.07em;
            position:relative;z-index:10;
            animation:fadein .4s .65s both;
        }

        .status-pill{
            display:flex;align-items:center;gap:.4rem;
            font-size:.6rem;color:var(--accent);
        }
        .status-pill::before{
            content:'';width:5px;height:5px;
            background:var(--accent);border-radius:50%;
            animation:blink 1.2s step-end infinite;
        }

        @keyframes fadein{from{opacity:0}to{opacity:1}}
        @keyframes slideup{
            from{opacity:0;transform:translateY(14px)}
            to{opacity:1;transform:translateY(0)}
        }
        @keyframes blink{0%,100%{opacity:1}50%{opacity:.15}}
    </style>
</head>
<body>

<nav class="topbar">
    <div class="topbar-left">
        <span class="logo">System</span>
        <span class="sep">/</span>
        <span class="breadcrumb">error <span>› 500</span></span>
    </div>
    <div class="topbar-right"><%= new java.util.Date() %></div>
</nav>

<main>
    <div class="card">
        <div class="card-header">
            <span class="card-title">HTTP Response</span>
            <span class="card-code">ERR_INTERNAL_SERVER</span>
        </div>
        <div class="card-body">
            <div class="error-number" data-n="500">500</div>
            <div class="error-label">Internal Server Error</div>
            <div class="divider"></div>
            <p class="message">На сервере возникло необработанное исключение.<br>Детали ошибки — ниже.</p>

            <div class="trace">
                <div class="trace-header">
                    <span class="trace-header-left">Stack Trace</span>
                    <%
                        Throwable ex = (Throwable) request.getAttribute("javax.servlet.error.exception");
                        if (ex == null) ex = exception;
                    %>
                    <span class="trace-exception"><%= ex != null ? ex.getClass().getSimpleName() : "Unknown" %></span>
                </div>
                <div class="trace-body">
                    <% if (ex != null) { %>
                    <div class="exc-type"><%= ex.getClass().getName() %></div>
                    <% if (ex.getMessage() != null) { %>
                    <div class="exc-msg"><%= ex.getMessage() %></div>
                    <% } %>
                    <ul class="trace-lines">
                        <% StackTraceElement[] st = ex.getStackTrace();
                            int lim = Math.min(st.length, 6);
                            for (int i = 0; i < lim; i++) {
                                StackTraceElement e = st[i]; %>
                        <li>
                            <span class="cls"><%= e.getClassName() %>.</span><span class="mth"><%= e.getMethodName() %></span>
                            <span class="ref">(<%= e.getFileName() != null ? e.getFileName() : "Unknown" %>:<%= e.getLineNumber() %>)</span>
                        </li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <div class="no-trace">Информация об исключении недоступна.</div>
                    <% } %>
                </div>
            </div>

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
    <span class="status-pill">500 Internal Server Error</span>
</footer>

</body>
</html>