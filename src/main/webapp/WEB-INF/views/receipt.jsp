<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/transfer.css"/>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<body>
    <p class="fontS-35">이체 완료</p>
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="text" name="tr_ac_seq" disabled value=${tr_ac_seq}>
                </td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>
                    <input class="transfer-input" type="text" name="tr_other_bank" disabled value=${tr_other_bank}>
                </td>
            </tr>
            <tr>
                <th scope="row">입금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_other_accnum" disabled value=${tr_other_accnum}>
                </td>
            </tr>
            <tr>
                <th scope="row">이체 금액</th>
                <td>
                    <input class="transfer-input" type="number" name="tr_amount" id='result' disabled value=${tr_amount}>
                </td>
            </tr>
            <tr>
                <th scope="row">통장 메모</th>
                <td>
                    <input class="transfer-input" type="text" name="tr_msg" disabled value=${tr_msg}>
                </td>
            </tr>
            <tr>
                <th scope="row">이체 후 잔액</th>
                <td>
                    <input class="transfer-input" name="tr_after_balance" disabled value=${tr_after_balance}>
                </td>
            </tr>
            <tr>
                <th scope="row">이체 날짜</th>
                <td>
                    <input class="transfer-input"  name="tr_date" disabled value=${tr_date}>
                </td>
            </tr>
        </table>
    <button style="margin-left:300px" type="button" onclick="newPage()" class="transfer-btn">확인</button>
</body>

 <script language="javascript">
 	function newPage(){
 		window.close();
 	}
 </script>