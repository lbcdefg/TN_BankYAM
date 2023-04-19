<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌 - 회원가입</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body class="join-body">
    <div class="join-header">
        <div class="inner">
            <h1 class="join-header-title">회원가입</h1>
        </div>
    </div>
    <div class="join">
        <div class="inner">
            <div class="join-body">
                <form name="f" method="post"  id="join-form" action="editProfile_ok" class="join-page" novalidate="novalidate">
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
                            <div class="row-half">
                                <label>비밀번호</label>
                                <input type="password" id="mb_pwd" name="mb_pwd" class="form-control margin-bottom-20" autocomplete="off">
                            </div>
                            <div class="row-half">
                                <label>비밀번호 (확인)</label>
                                <input type="password"id="mb_pwd2" name="mb_pwd2" class="form-control margin-bottom-20" autocomplete="off">
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
                                    <option value="" name="">==선택==</option>
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
                        </div>
                        <hr>
                        <div class="row">
                            <div class="row-in"></div>
                            <div class="row-in half-in-btn">
                                <button type="button" onclick="f.submit()" class="edit-btn">수정</button>
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

	function check(target){
	    $("#join_message").html("<span id='emconfirmchk'></span>");
        $("#emconfirmchk").css({
            "color" : "#FA3E3E",
            "font-weight" : "bold",
            "font-size" : "13px"
        });
        if(target == form.mb_email){
            var emailVal = form.mb_email.value;
            emailVal = trim(emailVal);
            if(emailVal.length == 0){
                $("#join_message").html("<span id='emconfirmchk'>이메일 인증을 진행해주세요</span>");
                $("#mb_email").focus();
                return false;
            }else if(blankExp.test(emailVal)){
                $("#join_message").html("<span id='emconfirmchk'>이메일 형식에 맞지 않습니다</span>");
                $("#mb_email").focus();
                return false;
            }else if(!checkEmail(emailVal)){
                 $("#join_message").html("<span id='emconfirmchk'>이메일 형식에 맞지 않습니다</span>");
                 $("#mb_email").focus();
                 return false;
            }
        }else if(target == form.mb_pwd || target == form.mb_pwd2){
            var pwdVal = form.mb_pwd.value;
            var pwd2Val = form.mb_pwd2.value;
            if(check_byte(pwdVal)<4){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호가 너무 짧습니다</span>");
                $("#mb_pwd").focus();
                return false;
            }else if(check_byte(pwdVal)>15){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호가 너무 깁니다</span>");
                $("#mb_pwd").focus();
                return false;
            }else if(checkPwdVal.length == 0){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호 확인을 진행해주세요</span>");
                $("#mb_pwd2").focus();
                return false;
            }else if(pwdVal != pwd2Val){
                $("#join_message").html("<span id='emconfirmchk'>두 비밀번호가 일치하지 않습니다</span>");
                $("#mb_pwd2").focus();
                return false;
            }
        }else if(target == form.mb_name){
            var nameFoc = f.mb_name;
            var nameVal = nameFoc.value;
            nameVal = trim(nameVal);
            if(nameVal.length==0){
                $("#join_message").html("<span id='emconfirmchk'>이름을 입력해주세요</span>");
                $("#mb_name").focus();
                return false;
            }else if(regExp.test(nameVal) | blankExp.test(nameVal)){
                $("#join_message").html("<span id='emconfirmchk'>이름에 공백이나 기호를 입력할 수 없습니다</span>");
                $("#mb_name").focus();
                return false;
            }else if(nameVal.search(/[0-9]/g) > -1){
                $("#join_message").html("<span id='emconfirmchk'>이름에 숫자를 입력할 수 없습니다</span>");
                $("#mb_name").focus();
                return false;
            }else if(nameVal.length<2){
                $("#join_message").html("<span id='emconfirmchk'>이름이 너무 짧습니다</span>");
                $("#mb_name").focus();
                return false;
            }else if(check_byte(nameVal)>20){
                $("#join_message").html("<span id='emconfirmchk'>이름이 너무 깁니다</span>");
                $("#mb_name").focus();
                return false;
            }
        }else if(target == form.mb_phone){
            var phoneFoc = form.mb_phone;
            var phoneVal = phoneFoc.value;
            if(phoneVal.length!=11){
                $("#join_message").html("<span id='emconfirmchk'>전화번호는 11자리로 작성해주세요</span>");
                $("#mb_addrdetail").focus();
                return false;
            }
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

	// 이메일 형식 체크 기능
    	function checkEmail(str){
    		var exp = /@/;
    		if(regExp.test(str)) {
    			if(str.split('@',2)[1].length != 0){
    			    console.log("조각1: " + str.split('@',2)[0]);
    			    console.log("조각2: " + str.split('@',2)[1]);
    			    str = str.split('@',2)[1];
    			    if(str.split('.',2)[0].length !=0 && str.split('.',2)[1].length !=0){
                        console.log("조각2-1: " + str.split('.',2)[0]);
                        console.log("조각2-2: " + str.split('.',2)[0]);
    			        emailCodeBtn.style.display = 'block';
    			        return true;
    			    }else{
    			        return false;
    			    }
    			}else{
    			    return false;
    			}
    		}else{
    			return false;
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

