<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <link href="/css/transfer.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/transfer.js"></script>
    <title>BankYam transfer</title>
</head>

<body>
    <p class="fontS-35">${membery.mb_name}님의 계좌이체</p>
    <form method="post" name="f" action="transfer_chk" class="" novalidate="novalidate">
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                    <td>
                    <select name="ac_seq">
                    <option value="">계좌 선택</option>
                        <c:forEach var="accList" items="${accList}">
                            <option value="${accList.ac_seq}">${accList.ac_seq}(${accList.ac_main})</option>
                        </c:forEach>
                    </select>
                    </td>
            </tr>
            <tr>
                <th scope="row">계좌 비밀번호</th>
                <td>
                    <input class="pw" placeholder="숫자만 입력해주세요" type="password" name="ac_pwd" id="password_1" style="width: 300px;height: 32px;font-size: 15px;border: 0;border-radius: 15px;outline: none;padding-left: 10px;background-color: #F7F3EF;">
                </td>
            </tr>
            <tr>
                <th scope="row">비밀번호 확인</th>
                <td>
                    <input class="pw" placeholder="숫자만 입력해주세요" type="password" name="ac_pwd" id="password_2" style="width: 300px;height: 32px;font-size: 15px;border: 0;border-radius: 15px;outline: none;padding-left: 10px;background-color: #F7F3EF;">
                    <span id="alert-success" style="display: none;">비밀번호가 일치합니다.</span>
                    <span id="alert-danger" style="display: none; color: #d92742; font-weight: bold; ">비밀번호가 일치하지 않습니다.</span>
                </td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>
                <select name="tn_other_bank" id="tn_other_bank">
                    <option value="">은행선택</option>
                    <option value="뱅크얌">뱅크얌</option>
                    <option value="국민은행">국민은행</option>
                    <option value="우리은행">우리은행</option>
                    <option value="신한은행">신한은행</option>
                    <option value="하나은행">하나은행</option>
                    <option value="기업은행">IBK기업은행</option>
                    <option value="카카오뱅크">카카오뱅크</option>
                    <option value="NH농협">NH농협</option>
                    <option value="KDB산업은행">KDB산업은행</option>
                </select>
                </td>
            </tr>
            <tr>
                <th scope="row">입금 계좌번호</th>
                <td>
                    <input class="transfer-input" type="number" placeholder="숫자만 입력해주세요" name="tr_other_accnum">
                </td>
            </tr>
            <tr>
                <th scope="row">이체 금액</th>
                <td>

                    <input class="transfer-input" type="number" placeholder="숫자만 입력해주세요" name="tr_amount" id='result' value="0">
                    <br/><br/>
                        <input type="button" name="" class="amount-btn" value="만원" onclick='count("plus1")'/>
                        <input type="button" name="" class="amount-btn" value="오만원" onclick='count("plus5")'/>
                        <input type="button" name="" class="amount-btn" value="십만원" onclick='count("plus10")'/>
                        <input type="button" name="" class="amount-btn" value="백만원" onclick='count("plus100")'/>
                        <input type="button" name="" class="amount-btn" value="초기화" onclick='count("minus")'/>
                </td>
            </tr>
            <tr>
                <th scope="row">통장 메모</th>
                <td>
                    <input class="transfer-input" type="text" placeholder="(선택)최대 20자 이내 입력" name="tr_msg">
                </td>
            </tr>
        </table>
        <button style="margin-left:300px" type="button" onclick="newPage()" class="transfer-btn">다음</button>
    </form>
</body>