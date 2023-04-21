<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌 - 정보수정</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body class="join-body">
    <div class="join-header">
        <div class="inner">
            <h1 class="join-header-title">정보수정</h1>
        </div>
    </div>
    <div class="join">
        <div class="inner">
            <div class="join-body">
                <form name="f" method="post"  id="join-form" action="editProfile_ok" class="join-page" novalidate="novalidate" enctype="multipart/form-data">
                    <div class="page-header">
                        <h2>정보수정</h2><br/>
                    </div>
                    <div id="join-form2" class="join-page" style="margin:auto;">
                        <div class="row">
                            <div class="row-in">
                                <label>이메일</label>
                                <input type="text" id="mb_email" name="mb_email" class="form-control margin-bottom-20" value="${membery.mb_email}" style="background-color:#c8c8c8;" autocomplete="off" readonly />
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>이름</label>
                                <input type="text"id="mb_name" name="mb_name" class="form-control margin-bottom-20" value="${membery.mb_name}" autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>전화번호</label>
                                <input type="number"id="mb_phone" name="mb_phone" class="form-control margin-bottom-20" value="${membery.mb_phone}" placeholder="'-',공백 없이 숫자만 입력해주세요" autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>주소</label>
                                <input type="text"id="mb_addr" name="mb_addr" value="${membery.mb_addr}" class="form-control margin-bottom-20" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>상세주소</label>
                                <input type="text"id="mb_addrdetail" name="mb_daddr" value="${membery.mb_daddr}" class="form-control margin-bottom-20">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-half">
                                <label>직업</label>
                                <select id="mb_job" name="mb_job" class="form-control margin-bottom-20">
                                    <option value="${membery.mb_job}" name="">${membery.mb_job}</option>
                                    <option value="space" name="">==선택==</option>
                                    <option value="무직" name="">무직</option>
                                    <option value="학생" name="">학생</option>
                                    <option value="자영업" name="">자영업</option>
                                    <option value="회사원" name="">회사원</option>
                                    <option value="공무원" name="">공무원</option>
                                </select>
                            </div>
                            <div class="row-half">
                                <label>연봉</label>
                                <div style="display:flex">
                                <input type="number" id="mb_salary" name="mb_salary" value="${membery.mb_salary}" class="form-control margin-bottom-20 join-placeholderR" autocomplete="off">
                                <label style="padding-top: 15px;padding-left: 5px;">만원</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="row-in">
                                    <label>비밀번호</label>
                                    <input type="password" id="mb_pwd" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
                                    <p id="checkPwd"></p>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="row-in"></div>
                                <div class="row-in half-in-btn">
                                    <button type="button" onclick="check()" class="edit-btn">수정</button>
                                </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script language="javascript">
	const regExp = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g; //전체에서 특수문자 찾기
	const blankExp = /\s/g; //전체에서 공백찾기

	function check(){
            var nameFoc = f.mb_name;
            var nameVal = nameFoc.value;
            nameVal = trim(nameVal);
            if(nameVal.length==0){
                alert("이름을 입력해주세요");
                $("#mb_name").focus();
                return false;
            }else if(regExp.test(nameVal) | blankExp.test(nameVal)){
                alert("이름에 공백이나 기호를 입력할 수 없습니다");
                $("#mb_name").focus();
                return false;
            }else if(nameVal.search(/[0-9]/g) > -1){
                alert("이름에 숫자를 입력할 수 없습니다");
                $("#mb_name").focus();
                return false;
            }else if(nameVal.length<2){
                alert("이름이 너무 짧습니다");
                $("#mb_name").focus();
                return false;
            }else if(check_byte(nameVal)>20){
                alert("이름이 너무 깁니다");
                $("#mb_name").focus();
                return false;
            }else if(check_phone()){
                f.submit();
            }else{
                 $("#mb_name").focus();
                 return false;
             }
	}
	//전화번호 체크
	function check_phone(){
	    var phoneExp = /[e+-.]/g;
        var phoneFoc = f.mb_phone;
        var phoneVal = phoneFoc.value;
        if(phoneVal.length!=11){
            alert("전화번호는 11자리로 작성해주세요");
            $("#mb_phone").focus();
            return false;
        }else if(phoneExp.test(phoneVal)){
            alert("전화번호에 공백이나 기호를 입력할 수 없습니다");
            $("#mb_phone").focus();
            return false;
        }else if(check_addr()){
            return true;
         }else{
             $("#mb_phone").focus();
             return false;
         }
	}
	//주소 체크
	function check_addr(){
	    var addrdVal = f.mb_daddr.value;
        if(addrdVal.length==0){
            alert("상세주소를 입력해주세요");
            $("#mb_daddr").focus();
            return false;
        }else if(check_salary()){
            return true;
        }else{
            $("#mb_daddr").focus();
            return false;
        }
	}
	//연봉체크
	function check_salary(){
	    var salVal = f.mb_salary.value;
         if(salVal.length==0){
             alert("연봉을 입력해주세요");
             return false;
         }else if(check_job()){
              return true;
         }else{
            $("#mb_salary").focus();
            return false;
         }
	}
	//직업체크
    function check_job(){
        var jobVal = f.mb_job.value;
        if(jobVal == "space"){
            alert("직업을 선택해주세요");
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
	$("#mb_pwd").keyup(function(){
	    $.ajax({
	        type: "GET",
	        url: "checkPwd",
	        data: {pwd: $("#mb_pwd").val()},
	        success: function(result){
	            if(result){
	                console.log("입력된 전화번호는 : " + $("#mb_pwd").val());
	                $("#checkPwd").html("마자용");
	                return true;
	            }else{
	                console.log("입력된 전화번호는 : " + $("#mb_pwd").val());
	                $("#checkPwd").html("틀린 비밀번호");
	                return false;
	            }
	        }
	    })
	})


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 주소찾기
    const mb_addr = document.getElementById("mb_addr")
    mb_addr.addEventListener("click", function(){
        new daum.Postcode({
            oncomplete: function(data) {
                mb_addr.value = data.address;
                form.mb_addrdetail.focus();
            }
        }).open();
    });
</script>

