<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link href="/css/transactionList.css" rel="stylesheet" type="text/css">
    <title>뱅크얌 거래내역</title>
</head>

    <body>
        <div class="tr-frame body-main">
            <button onclick="window.open('transfer', '_blank', 'width=800 height=600')"> 계좌이체 </button>
            <c:if test="${not empty membery}">
                <p class="tr-title fontS-35">${membery.mb_name}님의 거래내역</p>
            </c:if>
            <div class="tr-table-size350">
                <table class="tr-list-table">
                    <tr class="tr-list-head">

                        <th class="tr-list-10">계좌번호</th>
                        <th class="tr-list-10">타인 계좌번호</th>
                        <th class="tr-list-10">은행</th>
                        <th class="tr-list-10">유형</th>
                        <th class="tr-list-10">금액</th>
                        <th class="tr-list-10">잔액</th>
                        <th class="tr-list-10">메시지</th>
                        <th class="tr-list-10">날짜</th>
                    </tr>
                    <c:if test="${empty trList}">
                        <tr class="tr-list-row" style="border:none; height:400px">
                            <td class="fontS-35" align='center' colspan="6">거래내역이 없습니다</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${trList}" var="tr">
                        <tr class="tr-list-row">
                            <td class="tr-list-10" name="tr.tr_ac_seq">${tr.tr_ac_seq}</td>
                            <td class="tr-list-10" name="tr.tr_other_accnum">${tr.tr_other_accnum}</td>
                            <td class="tr-list-10" name="tr.tr_other_bank">${tr.tr_other_bank}</td>
                            <td class="tr-list-10" name="tr.tr_type">${tr.tr_type}</td>
                            <td class="tr-list-10" name="tr.tr_amount">${tr.tr_amount}</td>
                            <td class="tr-list-10" name="tr.tr_after_balance">${tr.tr_after_balance}</td>
                            <td class="tr-list-10" name="tr.tr_msg">${tr.tr_msg}</td>
                            <td class="tr-list-10" name="tr.tr_date">${tr.tr_date}</td>
                        </tr>
                     </c:forEach>
                </table>
            </div>
        </div>
    </body>
<%@ include file="/WEB-INF/views/footer.jsp" %>