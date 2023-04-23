<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<body>
    <form method="post" name="f" action="transfer_chk" class="" novalidate="novalidate">
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                    <td>${ac_seq}</td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>${}</td>
            </tr>
            <tr>
                <th scope="row">입금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_other_accnum">
                </td>
            </tr>
            <tr>
                <th scope="row">이체 금액</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_amount" id='result'>
                </td>
            </tr>
            <tr>
                <th scope="row">통장 메모</th>
                <td>
                    <input class="transfer-input" type="text" placeholder="(선택)최대 20자 이내 입력" name="tr_msg">
                </td>
            </tr>
        </table>
        <button type="button" onclick="newPage()" class="transfer-btn">확인</button>
    </form>
</body>
