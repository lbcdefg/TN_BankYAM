<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" type="text/css" href="/css/transfer.css" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script language="javascript">
	const regExp = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g; //전체에서 특수문자 찾기
	const blankExp = /\s/g; //전체에서 공백찾기
	function newPage(){
		location.href="C:/Users/ZEN/Desktop/confirmation.html";
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
<body>
	<div class="transfer">
		<div class="transfer-inner">
		<h1 class="confirm">뱅크얌 계좌이체</h1>
		<div class="transfer-header">
			<div class="inner">
				<h3 class="transfer-header-title">출금정보</h3>
			</div>
		</div>
		<div class="inner">
			<div class="transfer-body">
				<form method="post" name="f" action="transfer_ok" class="transfer-page" novalidate="novalidate">
					
					<div class="row">
						<div class="row-in">
							<label>출금계좌번호</label>
							<input type="number" placeholder="숫자만 입력해주세요" name="mb_id" class="form-control margin-bottom-20" value="" autocomplete="off">
							<select>
								<option value="">출금계좌번호조회</option>
								<option value="1">11111111111111</option>
								<option value="2">22222222222222</option>
								<option value="3">33333333333333</option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="row-in">
							<label>계좌비밀번호</label>
							<input style="-webkit-text-security: disc;" type="number"placeholder="숫자4자리" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
							<label>확인</label>
							<input style="-webkit-text-security: disc;" type="number" placeholder="숫자4자리" name="mb_pwd2" class="form-control margin-bottom-20" autocomplete="off">
						</div>
					</div>

					<div class="transfer-header">
						<div class="inner">
							<h3 class="transfer-header-title">입금정보</h3>
						</div>
					</div>

					<div class="row">
						<div class="row-in">
							<label>입금은행</label>
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
						</div>
					</div>

					<div class="row">
						<div class="row-in">
							<label>입금계좌번호</label>
							<input type="number" placeholder="숫자만 입력해주세요" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
						</div>
					</div>

					<div class="row">
						<div class="row-in">
							<label>이체금액</label>
							<input type="number" name="" class="" id='result' value="0">
							<input type="button" name="" class="amount" value="만원" onclick='count("plus1")'/>
							<input type="button" name="" class="amount" value="오만원" onclick='count("plus5")'/>
							<input type="button" name="" class="amount" value="십만원" onclick='count("plus10")'/>
							<input type="button" name="" class="amount" value="백만원" onclick='count("plus100")'/>
							<input type="button" name="" class="amount" value="초기화" onclick='count("minus")'/>
						</div>
					</div>

					<div class="row">
						<div class="row-in">
							<label>통장메모</label>
							<input type="text" placeholder="(선택)최대 20자 이내 입력" name="mb_phone" class="form-control margin-bottom-20" value="" autocomplete="off">
						</div>
					</div>

					<div class="row">
						<div class="confirm">
							<button type="button" onclick="newPage()" class="transfer-btn">다음</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
</body>
