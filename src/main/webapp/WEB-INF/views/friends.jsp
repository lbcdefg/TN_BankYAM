<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <link href="/css/friends.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/trim.js"></script>
    <title>BankYam Friends</title>
</head>

<body style="margin:0">
    <div class="frs-frame">
        <div class="frs-lt">
            <div class="frs-search">
                <input type="text" class="frs-search-input" id="searchFr" size="20"/>
                <button type="button" class="frs-search-btn" onclick="checkFrSearch()">검색</button>
            </div>
            <div class="frs-findFr">
                <img class="frs-img-profile" src="/css/imgs/BankYamChracter.png">
                <p class="frs-name-profile">김좌진</p>
            </div>
        </div>

        <div class="frs-rt">

        </div>
    </div>
</body>

<script src="/js/friends.js"></script>