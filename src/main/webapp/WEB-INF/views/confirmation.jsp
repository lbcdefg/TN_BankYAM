<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <link href="/css/transfer.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/transfer.js"></script>
    <title>BankYam transfer confirm</title>
</head>
<script language="javascript">
	function newPage(){
		f.submit();
	}
</script>
<body>
    <p class="fontS-35">계좌이체 확인</p>
    <form method="post" name="f" action="transfer_ok" class="" novalidate="novalidate">
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                <td>
                     <input class="transfer-input" type="number" name="tr_other_accnum" readonly>
                </td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>
                     <input class="transfer-input" type="number" name="tr_other_accnum" readonly>
                </td>
            </tr>
            <tr>
                <th scope="row">입금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_other_accnum" readonly>
                </td>
            </tr>
            <tr>
                <th scope="row">이체 금액</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_amount" id='result' readonly>
                </td>
            </tr>
            <tr>
                <th scope="row">통장 메모</th>
                <td>
                    <input class="transfer-input" type="text" name="tr_msg" readonly>
                </td>
            </tr>
        </table>
        <div class="transfer-btn-div">
            <button type="button" onclick="history.back()" class="transfer-btn">이전</button>
            <button type="button" onclick="newPage()" class="transfer-btn">확인</button>
        </div>
    </form>
</body>
