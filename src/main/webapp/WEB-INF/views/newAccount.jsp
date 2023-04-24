<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/newAccount.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam New Account</title>
</head>

<body>
    <div class="nac-frame body-main">
        <div class="nac-frame-header">
            <h1 class="nac-header-title">신규 계좌 개설</h1>
        </div>
        <div class="nac-main">
            <form name="nacf" class="nac-form" method="post" action="accounts_newAc" novalidate>
                <div class="nac-row">
                    <div class="row-half">
                        <label>계좌비밀번호</label>
                        <input type="password" pattern="[0-9]*" class="form-control margin-bottom-20" id="ac_pwd" name="ac_pwd" maxlength="4" spellcheck="false" autocomplete="off">
                        <div class="nac-psC-pTag1"></div>
                    </div>
                    <div class="row-half">
                        <label>계좌비밀번호(확인)</label>
                        <input type="password" pattern="[0-9]*" class="form-control margin-bottom-20" id="ac_pwd2" name="ac_pwd2" maxlength="4" spellcheck="false" autocomplete="off">
                        <div class="nac-psC-pTag2"></div>
                    </div>
                </div>

                <div class="nac-row">
                    <div class="row-in-select">
                        <label>희망이자지급일</label>
                        <select id="ac_udated" name="ac_udated" class="form-control margin-bottom-20">
                            <option value="1">매월 1일</option>
                            <option value="5">매월 5일</option>
                            <option value="10">매월 10일</option>
                            <option value="15">매월 15일</option>
                            <option value="20">매월 20일</option>
                            <option value="25">매월 25일</option>
                        </select>
                    </div>
                </div>
                <div class="nac-row">
                    <div class="row-in-select">
                        <label>계좌개설목적</label>
                        <select id="ac_purpose" name="ac_purpose" class="form-control margin-bottom-20">
                            <option value="예금">예금</option>
                            <option value="급여">급여</option>
                            <option value="생활비">생활비</option>
                        </select>
                    </div>
                </div>
                <div class="nac-row">
                    <div class="row-in"></div>
                    <div class="row-in half-in-btn">
                        <button id="next-btn-3" type="button" onclick="next(this)" class="join-btn">회원가입</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>

<script src="/js/newAccount.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>