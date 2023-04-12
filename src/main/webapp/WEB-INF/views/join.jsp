<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script language="javascript">
	const regExp = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g; //전체에서 특수문자 찾기
	const blankExp = /\s/g; //전체에서 공백찾기

	function check(){
		var idFoc = f.mb_id;
		var idVal = idFoc.value;
		idVal = trim(idVal); //공백제거

		if(idVal.length == 0){ //idVal의 길이가 0이라면
			alert("아이디를 입력해 주세요");
			idFoc.focus(); //focus() : 해당 요소에 포커스를 부여하여 텍스트창의 경우 커서를 위치시켜 바로 입력할 수 있게 함
			return false;
		}else if(blankExp.test(idVal)){
			alert("아이디는 공백을 포함할 수 없습니다");
			idFoc.focus();
			return false;
		}else if(check_byte(idVal)>30){
			alert("아이디가 너무 깁니다");
			idFoc.focus();
			return false;
		}
		var pwdFoc = f.mb_pwd;
		var pwdVal = pwdFoc.value;
		var checkPwdFoc = f.mb_pwd2;
		var checkPwdVal = checkPwdFoc.value;

		if(pwdVal.length == 0){
			alert("Password를 입력해 주세요");
			pwdFoc.focus();
			return false;
		}else if(check_byte(pwdVal)<4){
			alert("비밀번호가 너무 짧습니다");
			pwdFoc.focus();
			return false;
		}else if(check_byte(pwdVal)>30){
			alert("비밀번호가 너무 깁니다");
			pwdFoc.focus();
			return false;
		}else if(checkPwdVal.length == 0){
			alert("2차 Password를 입력해 주세요");
			checkPwdFoc.focus();
			return false;
		}else if(pwdVal != checkPwdVal){
			alert("2차 Password를 확인해 주세요");
			checkPwdFoc.focus();
			return false;
		}
		var nameFoc = f.mb_name;
		var nameVal = nameFoc.value;
		nameVal = trim(nameVal);
		if(nameVal.length==0){
			alert("이름을 입력해 주세요");
			nameFoc.focus();
			return false;
		}else if(regExp.test(nameVal) | blankExp.test(nameVal)){
			alert("이름은 공백이나 특수문자가 포함될 수 없습니다");
			nameFoc.focus();
			return false;
		}else if(nameVal.search(/[0-9]/g) > -1){
			alert("이름은 숫자는 포함할 수 없습니다");
			nameFoc.focus();
			return false;
		}else if(nameVal.length<2){
			alert("이름이 너무 짧습니다.");
			nameFoc.focus();
			return false;
		}else if(check_byte(nameVal)>20){
			alert("이름이 너무 깁니다");
			nameFoc.focus();
			return false;
		}
		var phoneFoc = f.mb_phone;
		var phoneVal = phoneFoc.value;
		if(phoneVal.length!=11){
			alert("전화번호는 11자리로 작성해주세요.");
			nameFoc.focus();
			return false;
		}

		f.submit();
	}

	// 비밀번호 형식 체크 기능
	function checkPwd(str){
		var regExp = /^.*(?=^.{6,12}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		if(!regExp.test(str)) {
			return false;
		}else{
			return true;
		}
	}

	// 바이트 체크 기능(모델 Max-length 제한치 적용)
	function check_byte(str){
		stringByteLength = (function(s,b,i,c){
			for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
			return b
		})(str)
		return stringByteLength
	}
	function enterCheck(elm){
		if(event.keyCode == 13){
			if(elm == f.mbEmail){
				f.mbName.focus();
			}else if(elm == f.mbName){
				f.password.focus();
			}else if(elm == f.mbPassword){
				f.mbPassword2.focus();
			}else{
				check();
			}
		}
	}

	function setTerms(target){
	    let term = document.getElementById("join_terms");
	    switch(target){
	        case document.getElementById("join-terms1"): term.innerHTML="<p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p><p>이것은 전자금융거래기본약관</p>"; break;
	        case document.getElementById("term2-p"): term.innerHTML="<p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p><p>이것은 전자금융서비스이용약관</p>"; break;
	        case document.getElementById("term3-p"): term.innerHTML="<p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p><p>이것은 개인정보수집 및 이용동의서</p>"; break;
	    }
	}

	function next(target){
	    let form1 = document.getElementById("join-form1");
	    let form2 = document.getElementById("join-form2");
	    let form3 = document.getElementById("join-form3");
	    let term = document.getElementById("join_terms");
	    if(target==document.getElementById("next-btn-1")){
	        term.style.display='none';
	        form1.style.display = 'none';
            form2.style.display = 'block';
	    }else if(target==document.getElementById("next-btn-2")){
	        form2.style.display = 'none';
            form3.style.display = 'block';
	    }else{}
	}
	$(window).load(function(){
        $('#nex-btn-1').click(function(){
            var element = document.querySelector(".join-terms");
            if($("join-terms").is(':checked')){

            }
        });
    });

</script>
<head>
    <title>지금은 뱅크얌 - 회원가입</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="join-header">
	<div class="inner">
		<h1 class="join-header-title">회원가입</h1>
	</div>
</div>
<div class="join">
	<div class="inner">
		<div class="join-body">
			<form method="post"  name="join_show" action="join_ok.do" class="join-page" novalidate="novalidate">
				<div class="page-header">
                    <h2>회원가입</h2>
                    <div id="join_terms">약관내용</div>
                </div>
                <div id="join-form1">
                    <div class="row">
                        <div class="row-in">
                            <p id="term1-p">
                            <input id="join-terms1" type="checkbox" name="mb_id" class="join-terms" onclick="setTerms(this)">
                            <label for="join-terms1">전자금융거래기본약관</label>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <p id="term2-p" onclick="setTerms(this)">
                            <input id="join-terms2" type="checkbox" name="mb_name" class="join-terms">
                            <label for="join-terms2">전자금융서비스이용약관</label>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <p id="term3-p" onclick="setTerms(this)">
                            <input id="join-terms3" type="checkbox" name="mb_phone" class="join-terms">
                            <label for="join-terms3">개인정보수집·이용동의</label>
                            </p>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="row-half"></div>
                        <div class="row-half half-in-btn">
                            <button id="next-btn-1" type="button" onclick="next(this)" class="join-btn next-btn">다음</button>
                        </div>
                    </div>
                </div>

                <div id="join-form2" class="join_hidden1">
                    <div class="row">
                        <div class="row-in">
                            <label>이메일</label>
                            <input type="text" placeholder="" name="mb_id" class="form-control margin-bottom-20" value="" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-half">
                            <label>비밀번호</label>
                            <input type="password"placeholder="" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                        <div class="row-half">
                            <label>비밀번호 (확인)</label>
                            <input type="password" placeholder="" name="mb_pwd2" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <label>이름</label>
                            <input type="text" placeholder="" name="mb_name" class="form-control margin-bottom-20" value="" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <label>전화번호</label>
                            <input type="number" placeholder="" name="mb_phone" class="form-control margin-bottom-20" value="" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <label>주소</label>
                            <input type="number" placeholder="" name="mb_phone" class="form-control margin-bottom-20" value="" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-half">
                            <label>직업</label>
                            <input type="text" placeholder="" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                        <div class="row-half">
                            <label>연봉</label>
                            <input type="number" style="align-text:right;" placeholder="만원" name="mb_pwd2" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="row-half"></div>
                        <div class="row-half half-in-btn">
                            <button id="next-btn-2" type="button" onclick="next(this)" class="join-btn">다음</button>
                        </div>
                    </div>
                </div>

                <div id="join-form3" class="join_hidden1">
                    <div class="row">
                        <div class="row-half">
                            <label>계좌비밀번호</label>
                            <input type="password"placeholder="" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                        <div class="row-half">
                            <label>계좌비밀번호(확인)</label>
                            <input type="password" placeholder="" name="mb_pwd2" class="form-control margin-bottom-20" autocomplete="off">
                        </div>
                    </div>
                    <div class="row">
                        <div class="row-in">
                            <label>희망이자지급일</label>
                            <input type="text" placeholder="매월" name="mb_name" class="form-control margin-bottom-20" value="" autocomplete="off">
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="row-half"></div>
                        <div class="row-half half-in-btn">
                            <button id="next-btn-3" type="button" onclick="next(this)" class="join-btn">회원가입</button>
                        </div>
                    </div>
                </div>
            </form>
		</div>
	</div>
</div>
<div th:replace="/footer"></div>
</html>