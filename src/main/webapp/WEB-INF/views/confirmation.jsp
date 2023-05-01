<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <link href="/css/transfer.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam transfer confirm</title>
</head>
<body>
    <p class="fontS-35">계좌이체 확인</p>
    <form method="post" name="f" action="transfer_ok" class="" novalidate="novalidate">
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                <td>
                     <input class="transfer-input" type="number" name="tr_ac_seq" readonly value=${transactions.tr_ac_seq}>
                </td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>
                     <input class="transfer-input" name="tr_other_bank" readonly value=${transactions.tr_other_bank}>
                </td>
            </tr>
            <tr>
                <th scope="row">입금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_other_accnum" readonly value=${transactions.tr_other_accnum}>
                </td>
            </tr>
            <tr>
                <th scope="row">받는 사람</th>
                <td>

                    <input class="transfer-input" name="mb_name" readonly
                    <c:if test="${transactions.otherAccount.membery.mb_name eq null}">value="타행" </c:if>
                    <c:if test="${transactions.otherAccount.membery.mb_name ne null}">value=${transactions.otherAccount.membery.mb_name}</c:if>
                    >

                </td>
            </tr>
            <tr>
                <th scope="row">이체 금액</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_amount" id='result' readonly value=${transactions.tr_amount}>
                </td>
            </tr>
            <tr>
                <th scope="row">통장 메모</th>
                <td>
                    <input class="transfer-input" name="tr_msg" readonly value=${transactions.tr_msg}>
                </td>
            </tr>
        </table>
        <div class="transfer-btn-div">
            <button type="button" onclick="history.back()" class="transfer-btn">이전</button>
            <button type="button" onclick="newPage()" class="transfer-btn">확인</button>
        </div>
    </form>
</body>
<script language="javascript">
	function newPage(){
		f.submit();
	}
</script>