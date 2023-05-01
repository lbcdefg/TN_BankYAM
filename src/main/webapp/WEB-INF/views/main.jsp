<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body>
    <center>
        <div class="main-div">
            <div class="main-div-div1"></div>
            <div class="main-div-div2">
                <div class="main-button-div1">
                    <a onclick="openTrPop(0)" class="main-button1">
                        <div class="button-content">계좌이체</div>
                    </a>
                    <a href="/chat/list" class="main-button2">
                        <div class="button-content">얌톡</div>
                    </a>
                </div>
                <div class="main-button-div2">
                    <a href="/accountM/accounts" class="main-button3">
                        <div class="button-content">계좌관리</div>
                    </a>
                    <a href="/friend/friends?content=list" class="main-button4">
                        <div class="button-content">친구관리</div>
                    </a>
                </div>
            </div>
        </div>
        <div class="main-tit">
            <h3 class="title">이미 모두의 은행
                <br>
                지금은 <span class="text_under">뱅크얌</span>
            </h3>
        </div>
        <div class="main-intcom">
            <div class="intcom-div2"><img src="img/intcom_2.png" ></div>
            <div class="intcom-div1"><img src="img/intcom_1.png" ></div>
            <div class="intcom-div3"><h4 class="intcom-div3-tit"></h4></div>
            <div class="intcom-div4">
                <h4 class="intcom-div4-tit">대한민국 대표 글로벌 금융그룹</h4>
            </div>
        </div>
    <center>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>