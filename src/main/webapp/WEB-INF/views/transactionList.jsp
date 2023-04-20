<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>뱅크얌 거래내역</title>
</head>

    <body>
        <div>
            <button onclick="window.open('transfer', '_blank', 'width=800 height=600')"> 계좌이체 </button>
            <c:if test="${not empty membery}">
                <p>${membery.mb_name}님의 거래내역</p>
            </c:if>
            <div>
                <table>
                    <tr>
                        <th></th>
                        <th>계좌번호</th>
                        <th>타인 계좌번호</th>
                        <th>은행</th>
                        <th>금액</th>
                        <th>잔액</th>
                    </tr>
                    <c:if test="${empty trList}">
                        <tr>
                            <td>거래내역이 없습니다</td>
                        </tr>
                    <c:forEach items="${trList}" var="tr">
                        <tr>
                            <td name="${tr.tr_ac_seq}"></td>
                            <td name="${tr.tr_other_accnum}"></td>
                            <td name="${tr.tr_other_bank}"></td>
                            <td name="${tr.tr_type}"></td>
                            <td name="${tr.tr_amount}"></td>
                            <td name="${tr.tr_after_balance}"></td>
                            <td name="${tr.tr_msg}"></td>
                            <td name="${tr.tr_date}"></td>
                        </tr>

            </div>
        </div>
    </body>
<%@ include file="/WEB-INF/views/footer.jsp" %>