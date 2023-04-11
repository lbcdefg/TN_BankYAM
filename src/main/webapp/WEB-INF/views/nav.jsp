<head>
    <meta charset="utf-8">
    <title>뱅크얌</title>
    <link rel="stylesheet" type="text/css" href="css/nav.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script src="/js/trim.js"></script>
</head>
<body style="margin: 0;">
    <nav class="nav-main">
        <header class="nav-header">
            <div class="nav-header-1">
                <a href="index" title="메인 화면"><img src="css/imgs/YamLogo.png" class="nav-image"></a>
                <a href="index" title="메인 화면"><img src="css/imgs/YamLogoHover.png" class="nav-image-hover"></a>
            </div>
            <div class="nav-header-1">
            <ul class="nav-menu">
                <li class="nav-menu-item menu-show-full">
                    <a href="price.do">페이지</a>
                </li>
                <li class="nav-menu-item menu-show" id="nav-post">
                    <a href="#">뱅킹</a>
                    <div class="nav-post-box">
                        <a class="nav-hidden-a" href="#">이체</a>
                        <a class="nav-hidden-a" href="#">거래내역</a>
                        <a class="nav-hidden-a" href="#">계좌관리</a>
                    </div>
                </li>
                <li class="nav-menu-item menu-show" id="nav-post">
                    <a href="#">얌톡</a>
                    <div class="nav-post-box">
                        <a class="nav-hidden-a" href="#">대화방</a>
                        <a class="nav-hidden-a" href="#">친구관리</a>
                    </div>
                </li>
                <li class="nav-menu-item menu-show-full">
                    <a href="introduce">뱅크얌</a>
                </li>
                <li class="nav-menu-item log-btn">
                    <button class="log-btn-full" onclick="location.href='logout.do'">JOIN</button>
                </li>
                <li class="nav-menu-item log-btn">
                    <button class="log-btn-full">LOGIN</button>
                </li>
            </ul>
            <div class="response-login"><button class="response-login-button"><img src="login.png" id="login-image" style="width:100%;height:100%;object-fit:cover;"/></button></div>
            </div>
        </header>
    </nav>
</body>

<script> //로그인
    const modal_login = document.querySelector('.modal_login');
    const login_button = document.querySelector('.login-button');
    const login_button2 = document.querySelector('.response-login-button');
    const cancle_button = document.querySelector('.cancle_button');
    function togglemodal() {
        modal_login.classList.toggle("show-login");
    }
    function windowOnClick(event) {
        if (event.target === modal_login) {
            togglemodal();
        }
    }
    <c:if test="${empty email}">
        login_button.addEventListener("click", togglemodal);
        login_button2.addEventListener("click", togglemodal);
    </c:if>
    cancle_button.addEventListener("click", togglemodal);
    window.addEventListener("click", windowOnClick);
</script>
