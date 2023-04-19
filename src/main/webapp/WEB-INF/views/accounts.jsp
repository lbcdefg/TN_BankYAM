<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/accounts.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam Friends</title>
</head>

<body>
    <div class="acs-frame body-main">
        <c:if test="${not empty membery}">
            <p class="acs-title fontS-35">${membery.mb_name} 님의 계좌</p>
        </c:if>
        <div class="acs-table-size">
            <table class="acs-list-table">
                <tr class="acs-list-head">
                    <th class="acs-list-5"></th>
                    <th class="acs-list-20">계좌번호</th>
                    <th class="acs-list-23">계좌별칭</th>
                    <th class="acs-list-12">주 계좌설정</th>
                    <th class="acs-list-10">계좌상태</th>
                    <th class="acs-list-10">휴면전환</th>
                    <th class="acs-list-10">해지</th>
                    <th class="acs-list-10">계좌생성일</th>
                </tr>
                <c:if test="${empty acList}">
                    <tr class="acs-list-row" style="border:none; height:400px">
                        <td class="fontS-35" align='center' colspan="6">계좌가 없습니다.. 왜죠!?</td>
                    </tr>
                </c:if>
                <c:forEach items="${acList}" var="ac">
                <c:choose>
                    <c:when test="${ac.ac_status == '해지'}">
                    <tr class="acs-list-row">
                        <td class="acs-list-5 acm" id="${ac.ac_seq}" name="${ac.ac_main}">${ac.ac_main}</td>
                        <td class="acs-list-20">${ac.ac_seq}</td>
                        <td class="acs-list-23">${ac.ac_name}<div class="acs-nameM"></div></td>
                        <td class="acs-list-12"></td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-20 fontS-12" colspan="2">계좌해지 일자: ${ac.ac_xdate}</td>
                    </c:when>
                    <c:otherwise>
                    <tr class="acs-list-row">
                        <td class="acs-list-5 acm" id="${ac.ac_seq}" name="${ac.ac_main}">${ac.ac_main}</td>
                        <td class="acs-list-20">${ac.ac_seq}</td>
                        <td class="acs-list-23">${ac.ac_name}<div class="acs-nameM"><button type="button" class="acs-nameM-btn">수정</button></div></td>
                        <td class="acs-list-12"><input type="radio" name="acr" id="acr-${ac.ac_seq}"/></td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-10">
                            <c:if test="${ac.ac_status == '사용중'}">
                                <a class="acs-click" onclick="">휴면신청</a>
                            </c:if>
                            <c:if test="${ac.ac_status == '휴면'}">
                                <a class="acs-click" onclick="">휴면취소</a>
                            </c:if>
                        </td>
                    </c:otherwise>
                </c:choose>
                    <c:if test="${ac.ac_status == '사용중' or ac.ac_status == '휴면'}">
                        <td class="acs-list-10"><a class="acs-click" onclick="">해지신청</a></td>
                    </c:if>
                        <td class="acs-list-10">${ac.ac_rdate}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="acs-info">
            <p class="acs-p-info fontS-25">※해지된 계좌의 복구 및 기타 관련 문의는 뱅크얌 전화번호로 연락주세요..!</p>
        </div>
    </div>
</body>

<script src="/js/accounts.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>