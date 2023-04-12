<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<head>
    <title>뱅크얌</title>
    <link rel="stylesheet" type="text/css" href="/css/nav.css" />
    <link rel="stylesheet" type="text/css" href="/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/css/footer.css" />
    <link rel="stylesheet" type="text/css" href="/css/login.css" />
    <link rel="stylesheet" type="text/css" href="/css/profile.css" />
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
    <script src="/js/trim.js"></script>
</head>
<body style="margin: 0;">
    <nav class="nav-main">
        <header class="nav-header">
            <div class="nav-header-1">
                <a href="/" title="메인 화면"><img src="/img/YamLogo.png" class="nav-image"></a>
                <a href="/" title="메인 화면"><img src="/img/YamLogoHover.png" class="nav-image-hover"></a>
            </div>
            <div class="nav-header-1">
            <ul class="nav-menu">
                <li class="nav-menu-item menu-show-full">
                    <a href="">페이지</a>
                </li>
                <li class="nav-menu-item menu-show" id="nav-post">
                    <a href="#">뱅킹</a>
                    <div class="nav-post-box">
                        <a class="hidden-a" href="#">이체</a>
                        <a class="hidden-a" href="#">거래내역</a>
                        <a class="hidden-a" href="#">계좌관리</a>
                    </div>
                </li>
                <li class="nav-menu-item menu-show" id="nav-post">
                    <a href="#">얌톡</a>
                    <div class="nav-post-box">
                        <a class="hidden-a" href="#">대화방</a>
                        <a class="hidden-a" href="#">친구관리</a>
                    </div>
                </li>
                <li class="nav-menu-item menu-show-full">
                    <a href="">뱅크얌</a>
                </li>
                <li class="nav-menu-item log-btn">
                    <button class="log-btn-full" onclick="location.href='/member/join'">JOIN</button>
                </li>
                <li class="nav-menu-item log-btn">
                    <button class="log-btn-full" onclick="location.href='/member/login'">LOGIN</button>
                </li>
            </ul>
            <div class="response-login"><button class="response-login-button"><img src="/img/login.png" id="login-image" style="width:100%;height:100%;object-fit:cover;"/></button></div>
            </div>
        </header>
    </nav>
</body>

