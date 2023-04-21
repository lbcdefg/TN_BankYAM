<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script language="javascript">
	const regExp = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g; //전체에서 특수문자 찾기
	const blankExp = /\s/g; //전체에서 공백찾기
	function newPage(){
		f.submit();
	}
	function count(type)  {
		// 결과를 표시할 element
		const resultElement = document.getElementById('result');
		// 현재 화면에 표시된 값
		let number = $('#result').val();


		// 더하기
		if(type === 'plus1') {
		  number = parseInt(number) + 10000;
		}else if(type === 'plus5')  {
		  number = parseInt(number) + 50000;
		}else if(type === 'plus10')  {
			number = parseInt(number) + 100000;
		}else if(type === 'plus100')  {
			number = parseInt(number) + 1000000;
		}else if(type === 'minus'){
			number = 0;
		}
		// 결과 출력
		//resultElement.innerText = number;
		$('#result').val(number);
	}
</script>

<head>
    <link href="/css/transfer.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam transfer</title>
</head>

<body>
    <p class="fontS-35">${membery.mb_name}님의 계좌이체</p>
    <form method="post" name="f" action="transfer_chk" class="" novalidate="novalidate">
        <table class="transfer-table">
            <tr>
                <th scope="row">출금 계좌번호</th>
                    <td>
                    <select>
                        <c:forEach var="seq" items="${list}">
                            <option value="${seq.ac_seq}">계좌 선택</option>
                            <option>${seq.ac_seq}</option>
                        </c:forEach>
                    </select>
                    </td>
            </tr>
            <tr>
                <th scope="row">계좌 비밀번호</th>
                <td>
                    <input class="transfer-input" placeholder="숫자만 입력해주세요" type="text" name="ac_pwd">
                </td>
            </tr>
            <tr>
                <th scope="row">비밀번호 확인</th>
                <td>
                    <input class="transfer-input" placeholder="숫자만 입력해주세요" type="text" name="ac_pwd_chk">
                </td>
            </tr>
            <tr>
                <th scope="row">은행</th>
                <td>
                <select>
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
                    <br/>
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
        <button type="button" onclick="newPage()" class="transfer-btn">다음</button>
    </form>
</body>