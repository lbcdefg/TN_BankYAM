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
                <form method="post"  id="join-form" action="join_ok" class="join-page" novalidate="novalidate">
                    <div class="page-header">
                        <h2>회원가입</h2><br/>
                        <div id="join_terms">약관을 모두 확인해주세요</div>
                        <p id="join_message"></p>
                    </div>
                    <div id="join-form1">
                        <div class="row">
                            <div class="row-in">
                                <p id="term1-p" onclick="setTerms(this)">
                                <input id="join-terms1" type="checkbox" class="join-terms" >
                                <label for="join-terms1">전자금융거래기본약관 동의</label>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <p id="term2-p" onclick="setTerms(this)">
                                <input id="join-terms2" type="checkbox" class="join-terms">
                                <label for="join-terms2">전자금융서비스이용약관 동의</label>
                                </p>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <p id="term3-p" onclick="setTerms(this)">
                                <input id="join-terms3" type="checkbox"  class="join-terms">
                                <label for="join-terms3">개인정보수집·이용동의</label>
                                </p>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="row-1quater"></div>
                            <div class="row-1quater">
                                <button id="next-btn-1" type="button" onclick="next(this)" class="join-btn normal-btn next-btn">다음</button>
                            </div>
                            <div class="row-1quater"></div>
                        </div>
                    </div>

                    <div id="join-form2" class="join_hidden1">
                        <div class="row">
                            <div class="row-3quater">
                                <label>이메일</label>
                                <input type="text" id="mb_email" name="mb_email" class="form-control" value="" autocomplete="off">

                            </div>
                            <div class="row-1quater">
                                <div class="join-wbtn">
                                    <button id="emailCodebtn" type="button" class="normal-btn" style="display:none;">코드발송</button>&nbsp;
                                    <button id="emailReset"  type="button" class="normal-btn">다시입력</button>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label for="emailCode" id="emailCodeTxt">인증코드</label>
                                <input type="text" placeholder="인증코드를 입력해주세요" id="emailCode" name="emailCode" class="form-control" value="" autocomplete="off">
                                <input type="hidden" id="emailCodeVs">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-half">
                                <label>비밀번호</label>
                                <input type="password" id="mb_pwd" name="mb_pwd" class="form-control" autocomplete="off">
                            </div>
                            <div class="row-half">
                                <label>비밀번호 (확인)</label>
                                <input type="password"id="mb_pwd2" name="mb_pwd2" class="form-control" autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>이름</label>
                                <input type="text"id="mb_name" name="mb_name" class="form-control" value="" autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>전화번호</label>
                                <input type="number"id="mb_phone" name="mb_phone" class="form-control" maxlength=11 placeholder="'-',공백 없이 숫자만 입력해주세요" autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>주소</label>
                                <input type="text"id="mb_addr" name="mb_addr" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>상세주소</label>
                                <input type="text"id="mb_daddr" name="mb_daddr" class="form-control">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-half">
                                <label>직업</label>
                                <select id="mb_job" name="mb_job" class="form-control">
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
                                    <input type="number" id="mb_salary" name="mb_salary" class="form-control" autocomplete="off">
                                    <label style=" padding-left: 5;">만원</label>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="row-1quater"></div>

                            <div class="row-1quater half-in-btn">
                                <button id="next-btn-2" type="button" onclick="next(this)" class="join-btn normal-btn next-btn">다음</button>
                            </div>
                            <div class="row-1quater"></div>
                        </div>
                    </div>

                    <div id="join-form3" class="join_hidden1">
                        <div class="row">
                            <div class="row-half">
                                <label>계좌비밀번호</label>
                                <input type="password" pattern="[0-9]*" id="ac_pwd" name="ac_pwd" maxlength="4" spellcheck="false"  class="form-control acpwd " autocomplete="off">
                            </div>
                            <div class="row-half">
                                <label>계좌비밀번호(확인)</label>
                                <input type="password" pattern="[0-9]*" id="ac_pwd2" name="ac_pwd2" maxlength="4" spellcheck="false"  class="form-control acpwd " autocomplete="off">
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>희망이자지급일</label>
                                <select id="ac_udated" name="ac_udated" class="form-control">
                                    <option value="1">매월 1일</option>
                                    <option value="5">매월 5일</option>
                                    <option value="10">매월 10일</option>
                                    <option value="15">매월 15일</option>
                                    <option value="20">매월 20일</option>
                                    <option value="25">매월 25일</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="row-in">
                                <label>계좌개설목적</label>
                                <select id="ac_purpose" name="ac_purpose" class="form-control">
                                    <option value="예금">예금</option>
                                    <option value="급여">급여</option>
                                    <option value="생활비">생활비</option>
                                </select>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="row-1quater"></div>
                            <div class="row-1quater half-in-btn">
                                <button id="next-btn-3" type="button" onclick="next(this)" class="join-btn normal-btn">회원가입</button>
                            </div>
                            <div class="row-1quater"></div>
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
    const form1 = document.getElementById("join-form1");
    const form2 = document.getElementById("join-form2");
    const form3 = document.getElementById("join-form3");
    const nextbtn1 = document.getElementById('next-btn-1');
    const nextbtn2 = document.getElementById('next-btn-2');
    const nextbtn3 = document.getElementById('next-btn-3');
    const emailCodeBtn = document.getElementById('emailCodebtn');
    const emailReset = document.getElementById('emailReset');
    const term = document.getElementById("join_terms");
    const form = document.getElementById("join-form");

    $("document").ready(function(){
        // 이메일 인증번호 체크 함수
        $("#emailCode").on("keyup", function(){
            if ($("#emailCodeVs").val() != $("#emailCode").val() || $("#emailCodeVs").val().length == 0){
                $("#join_message").html("<span id='emconfirmchk'>인증번호가 잘못되었습니다</span>");
                $("#emconfirmchk").css({
                    "color" : "#FA3E3E",
                    "font-weight" : "bold",
                    "font-size" : "13px"
                });
            }else{
                $("#join_message").html("<span id='emconfirmchk'>인증번호 확인 완료</span>");
                console.log("정답");
                $("#emconfirmchk").css({
                    "color" : "#0D6EFD",
                    "font-weight" : "bold",
                    "font-size" : "13px"
                });
                document.getElementById('emailCode').readOnly=true;
                document.getElementById('mb_email').readOnly=true;
                emailCodeBtn.style.display = 'none';
                document.getElementById('emailCode').setAttribute('style','background-color:#c8c8c8;');
                document.getElementById('mb_email').setAttribute('style','background-color:#c8c8c8;');
            }
        });
        $("#join-form2").on('keydown',function(event) {
            if(event.keyCode == 13){
                console.log(event.target);
                if(event.target == form.emailCode){
                    form.mb_pwd.focus();
                }else if(event.target == form.mb_pwd){
                    form.mb_pwd2.focus();
                }else if(event.target == form.mb_pwd2){
                    form.mb_name.focus();
                }else if(event.target == form.mb_name){
                    form.mb_phone.focus();
                }else if(event.target == form.mb_phone){
                    form.mb_addr.focus();
                }else if(event.target == form.mb_addr){
                    form.mb_daddr.focus();
                }else if(event.target == form.mb_daddr){
                    form.mb_salary.focus();
                }
            }
        });
    });


    // form2 유효성검사
	function check(target){
	    emconfirmchk = false;
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
                emailCodeBtn.style.display = 'none';
                return false;
            }else if(blankExp.test(emailVal)){
                $("#join_message").html("<span id='emconfirmchk'>공백을 포함할 수 없습니다</span>");
                emailCodeBtn.style.display = 'none';
                return false;
            }else if(!checkEmail(emailVal)){
                 $("#join_message").html("<span id='emconfirmchk'>이메일 형식에 맞지 않습니다</span>");
                 emailCodeBtn.style.display = 'none';
                 return false;
            }else{
                $.ajax({
                    type : "GET",
                    url : "join/mailCheck",
                    data : {email: $("#mb_email").val()},
                    success : function(result){
                        if(!result){
                            console.log("입력된 이메일은 : " + $("#mb_email").val());
                            emailCodeBtn.style.display = 'block';
                            $("#join_message").html("<span id='emconfirmchk'>코드발송 버튼을 눌러주세요</span>");
                            return true;
                        }else{
                            $("#join_message").html("<span id='emconfirmchk'>이미 가입된 이메일입니다</span>");
                            emailCodeBtn.style.display = 'none';
                            return false;
                        }
                    }
                });
            }
        }else if(target == form.mb_pwd || target == form.mb_pwd2){
            var pwdVal = form.mb_pwd.value;
            var pwd2Val = form.mb_pwd2.value;
            if(check_byte(pwdVal)<4){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호가 너무 짧습니다</span>");
                return false;
            }else if(check_byte(pwdVal)>15){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호가 너무 깁니다</span>");
                return false;
            }else if(pwdVal.length == 0){
                $("#join_message").html("<span id='emconfirmchk'>비밀번호 확인을 진행해주세요</span>");
                return false;
            }else if(pwdVal != pwd2Val){
                $("#join_message").html("<span id='emconfirmchk'>두 비밀번호가 일치하지 않습니다</span>");
                return false;
            }else{
                return true;
            }
        }else if(target == form.mb_name){
            var nameVal = form.mb_name.value;
            nameVal = trim(nameVal);
            if(nameVal.length==0){
                $("#join_message").html("<span id='emconfirmchk'>이름을 입력해주세요</span>");
                return false;
            }else if(regExp.test(nameVal) | blankExp.test(nameVal)){
                $("#join_message").html("<span id='emconfirmchk'>이름에 공백이나 기호를 입력할 수 없습니다</span>");
                return false;
            }else if(nameVal.search(/[0-9]/g) > -1){
                $("#join_message").html("<span id='emconfirmchk'>이름에 숫자를 입력할 수 없습니다</span>");
                return false;
            }else if(nameVal.length<2){
                $("#join_message").html("<span id='emconfirmchk'>이름이 너무 짧습니다</span>");
                return false;
            }else if(check_byte(nameVal)>20){
                $("#join_message").html("<span id='emconfirmchk'>이름이 너무 깁니다</span>");
                return false;
            }else{
                return true;
            }
        }else if(target == form.mb_phone){
            var phoneExp = /[e+-.]/g;
            var phoneFoc = form.mb_phone;
            var phoneVal = phoneFoc.value;
            if(phoneVal.length!=11){
                $("#join_message").html("<span id='emconfirmchk'>숫자 11자리로만 입력 가능합니다</span>");
                return false;
            }else if(phoneExp.test(phoneVal)){
                $("#join_message").html("<span id='emconfirmchk'>숫자 11자리로만 입력 가능합니다</span>");
                return false;
            }else{
                return true;
            }
        }else if(target == form.mb_addr){
            var addrVal = form.mb_addr.value;
            if(addrVal.length==0){
                $("#join_message").html("<span id='emconfirmchk'>주소를 검색해주세요</span>");
                return false;
            }else{
                return true;
            }
        }else if(target == form.mb_daddr){
            var addrdVal = form.mb_daddr.value;
            if(addrdVal.length==0){
                $("#join_message").html("<span id='emconfirmchk'>상세주소를 입력해주세요</span>");
                return false;
            }else{
                return true;
            }
        }else if(target == form.mb_salary){
            var salVal = form.mb_salary.value;
            if(salVal.length==0){
                $("#join_message").html("<span id='emconfirmchk'>연봉을 입력해주세요</span>");
                return false;
            }
            return true;
        }else{
            $("#join_message").html("<span id='emconfirmchk'>모두 입력해주세요</span>");
            $("#emconfirmchk").css({
                "color" : "#FA3E3E",
                "font-weight" : "bold",
                "font-size" : "13px"
            });
            return false;
        }
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
        if(exp.test(str)) {
            if(str.split('@',2)[1].length != 0){
                str = str.split('@',2)[1];
                if(str.split('.',2)[0].length !=0 && str.split('.',2)[1].length !=0){
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

    // form1에서 라벨클릭시 해당 이용약관 보이기
    function setTerms(target){
        switch(target){
            case document.getElementById("term1-p"): term.innerHTML="<p>전자금융거래기본약관</p><p>Tropical Night 주식회사(이하 'TN'이라 함)은 이용자가 뱅크얌 홈페이지 서비스를 이용하기 위해 제공하신 개인정보를 매우 소중히 여기며, 이용자가 안심하고 뱅크얌 홈페이지 서비스를 이용하실 수 있도록 이용자의 개인정보보호에 최선을 다하고 있습니다. TN은 '정보통신망 이용촉진 및 정보보호 등에 관한 법률' 및 '개인정보보호법' 상의 개인정보보호 규정과 동 법률의 시행령을 준수하고 있으며, TN의 개인정보처리방침은 정부의 법률이나 TN의 내부 방침 변경 등으로 인하여 변경될 수 있으므로, 이러한 변경의 경우 변경사항을 이용자가 쉽게 확인하실 수 있도록 뱅크얌 홈페이지에 게시하고 있습니다. TN이 취급하는 모든 개인정보는 관련법령에 근거하거나 이용자의 동의에 의하여 수집 • 보유 및 처리되고 있습니다.</p><p></br>1. 개인정보의 수집 및 이용목적</br>(1) 서비스 제공을 위한 계약의 체결 및 서비스 이행</br>- 컨텐츠 제공, 금융거래 본인 인증 및 금융서비스 제공 등</br>- 이벤트 또는 행사에 참가하는 경우 인적사항의 확인, 당선 또는 당첨 여부 확인 및 안내, 이벤트 또는 행사 진행 관련 안내, 물품배송</br>(2) 회원관리</br>- 회원가입 및 서비스 이용시 본인의 확인, 분쟁조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달</br>- 불량회원의 부정 이용 방지와 비인가 사용 방지</br>- 회원의 관심분야에 따른 각종 개인 맞춤 서비스의 제공</br>- 회원가입 경로 파악 및 앱 內 행태정보를 통한 서비스 개선</br>- 상담신청에 대한 응대 등</br></p>"; break;
            case document.getElementById("term2-p"): term.innerHTML="<p>전자금융서비스이용약관</p><p></br>제 1 조 (목적)</br>본 약관은 Tropical Night 주식회사(이하 'TN'라 한다)와 회사가 제공하는 전자금융서비스(이하 '서비스'라 한다)를 이용하고자하는 고객 (이하 '이용자'라 한다)간에 서비스 이용에 관한 제반사항을 정함을 목적으로 한다.</br></br>제 2 조 (서비스 종류)</br>본 약관에 따른 서비스는 다음과 같다.</br></br>1. 조회서비스 : 계약사항조회, 입·출금거래내역, 계약심사조회, 청약철회, 수익증권저축(펀드)정보 등</br>2. 입금서비스 : 보험료 및 보험계약대출원리금, 개인대출원리금, 수익증권저축(펀드)불입금, 특정금전신탁MMT형 추가신탁 등</br>3. 출금서비스 : 보험계약대출금, 중도 및 만기보험금, 배당금, 해약환급금, 휴면보험금, 사고보험금, 대출금, 수익증권환매대금(저축재산), 특정금전신탁MMT형 해지 출금 및 정기예금형 만기출금 등</br>4. 변경 • 등록서비스 : 고객정보변경, 계약변경, 펀드변경, 자동이체등록, 자동대출등록, 자동송금등록, 카드관련서비스, 수익증권신규등록·매입신청·환매신청, 특정금전신탁 위탁자고객정보(주소, 전화번호, 이메일 등) 변경 등</br>5. 증명서발행 : 각종 납입증명서, 가입증서재발행, 보험계약대출 거래내역증명서 등</br></p>"; break;
            case document.getElementById("term3-p"): term.innerHTML="<p>개인정보수집 및 이용동의서</p><p>Tropical Night 주식회사(이하 'TN')는 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련된 이용자의 고충을 원활하게 처리할 있도록 다음과 같은 처리방침을 두고 있습니다.</br></br>1. 개인정보 처리 목적</br>회사는 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며, 이용목적이 변경될 시에는 사전동의를 구할 예정입니다.</br></br>(1) 보험계약 및 대출계약 체결 및 이행</br>- 보험계약 상담, 보험계약 체결 및 인수여부 결정판단</br>- 보험계약의 체결, 유지, 관리, 상담, 이행, 계약적부, 가불금의 지급 및 관리, 상담, 이행, 보험금의 지급, 심사, 보험사고 조사</br>- 조사연구, 서비스 제공, 순보험요율의 산출 및 검증</br>- 보험모집질서 유지, 공공기관의 정책자료로 제공</br>- 보험계약 및 보험금 청구에 이해관계가 있는 자와 대출계약 및 대출계약에 이해관계가 있는 자에 대한 법규 및 계약상 의무 이행</br>- 제환급금 및 대출금 지급신청 처리업무를 포함한 보험계약 및 대출계약 변경 처리</br>- 보험계약정보, 보험금지급정보, 채권결손처분 관리정보, 대출계약정보, 대출금 상환정보의 조회</br>- 대출계약의 체결여부 결정판단</br>- 대출계약의 체결, 유지, 관리, 상담, 이행, 대출금 지급 및 관리 등</br>- 개인식별정보, 신용거래정보, 신용능력정보, 공공정보, 신용등급 등 조회</br></p>"; break;
        }
    }


    // 각 form 에서 다음 혹은 가입 버튼 클릭시
	function next(target){
	    if(target==nextbtn1){
	        console.log("다음1버튼 클릭");
	        term.style.display='none';
	        form1.style.display = 'none';
            form2.style.display = 'block';
	    }else if(target==nextbtn2){
	        console.log("다음2버튼 클릭");
            if($('#mb_email').is('[readonly]') && $('#emailCode').is('[readonly]')){
                if(check(form.mb_pwd) && check(form.mb_pwd2) && check(form.mb_name) && check(form.mb_phone) && check(form.mb_daddr) && check(form.mb_salary)){
                    form2.style.display = 'none';
                    form3.style.display = 'block';
                }else{
                    emconfirmchk = false;
                    $("#join_message").html("<span id='emconfirmchk'>모든 정보를 입력해주세요</span>");
                    $("#emconfirmchk").css({
                        "color" : "#FA3E3E",
                        "font-weight" : "bold",
                        "font-size" : "13px"
                    });
                }
            }else{
                emconfirmchk = false;
                $("#join_message").html("<span id='emconfirmchk'>이메일 인증이 되지 않았습니다</span>");
                $("#emconfirmchk").css({
                    "color" : "#FA3E3E",
                    "font-weight" : "bold",
                    "font-size" : "13px"
                });
            }
            if(check(form.mb_pwd) && check(form.mb_pwd2) && check(form.mb_name) && check(form.mb_phone) && check(form.mb_daddr) && check(form.mb_salary)){
                form2.style.display = 'none';
                form3.style.display = 'block';
            }else{
                emconfirmchk = false;
                $("#join_message").html("<span id='emconfirmchk'>모든 정보를 입력해주세요</span>");
                $("#emconfirmchk").css({
                    "color" : "#FA3E3E",
                    "font-weight" : "bold",
                    "font-size" : "13px"
                });
            }
	    }else if(target==nextbtn3){
	        // 희망이자지급일에따른 alert내용
            var date = new Date();
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var actualRMonth = $("#ac_udated").val()< day ? month+2 : month+1

            let udateConfirm = confirm("이자는 개설 1달 경과 이후부터 지급 가능합니다.\n확인 하시면 회원가입 및 계좌개설이 완료되며\n첫 예금이자는 "+actualRMonth+"월 "+$("#ac_udated").val()+"일에 지급됩니다");
            if(udateConfirm == true){
                form.submit();
            }
	    }
	}


    // form1 다음페이지 버튼 활성화과정
	form1.addEventListener('click', function() {
	    let term_ck1 = document.getElementById('join-terms1').checked;
	    let term_ck2 = document.getElementById('join-terms2').checked;
	    let term_ck3 = document.getElementById('join-terms3').checked;
        if(term_ck1 == true && term_ck2 == true && term_ck3 == true){
            nextbtn1.style.display = 'block'
        }else{
            nextbtn1.style.display = 'none'
        }
    });


    // form2 에서 다시입력 버튼 클릭시 event
    $("#emailReset").click(function() {
        document.getElementById('mb_email').readOnly=false;
        document.getElementById('emailCode').readOnly=false;
        document.getElementById('emailCode').setAttribute('style','background-color:white;');
        document.getElementById('mb_email').setAttribute('style','background-color:white;');
        document.getElementById('mb_email').value = "";
        $('#emailCode').val("");
        $("#join_message").html("");
        $("#emailCodeVs").val("");
    });


    // form2 다음페이지 버튼 활성화과정
    form2.addEventListener('keydown',function() {
        if(event.keyCode == 13){
            check(event.target);
            if($('#mb_email').is('[readonly]') && $('#emailCode').is('[readonly]')){
                if(check(form.mb_pwd) && check(form.mb_pwd2) && check(form.mb_name) && check(form.mb_phone) && check(form.mb_daddr) && check(form.mb_salary)){
                    nextbtn2.style.display = 'block';
                }else{
                    nextbtn2.style.display = 'none';
                }
            }
        }
    });

    form2.addEventListener('click',function() {
        check(event.target);
        if($('#mb_email').is('[readonly]') && $('#emailCode').is('[readonly]')){
            if(check(form.mb_pwd) && check(form.mb_pwd2) && check(form.mb_name) && check(form.mb_phone) && check(form.mb_daddr) && check(form.mb_salary)){
                nextbtn2.style.display = 'block';
            }else{
                nextbtn2.style.display = 'none';
            }
        }
    });


    // form3 유효성검사
    form3.addEventListener('keydown', function(){
        let acpwd = document.getElementById('ac_pwd').value;
        let acpwd2 = document.getElementById('ac_pwd2').value;
        var exp = /[e+-.]/g;
        if(acpwd.length!=4 | exp.test(acpwd)){
            $("#join_message").html("<span id='emconfirmchk'>계좌비밀번호는 숫자 4자리입니다</span>");
            $("#ac_pwd").focus();
            nextbtn3.style.display = 'none'
            return false;
        }else if(acpwd2.length!=4 | exp.test(acpwd2)){
            $("#join_message").html("<span id='emconfirmchk'>비밀번호를 확인해주세요</span>");
            $("#ac_pwd2").focus();
            nextbtn3.style.display = 'none'
            return false;
        }else if(acpwd != acpwd2){
            $("#join_message").html("<span id='emconfirmchk'>두 비밀번호가 일치하지 않습니다</span>");
            $("#ac_pwd2").focus();
            nextbtn3.style.display = 'none'
            return false;
        }else{
            emconfirmchk = true;
            $("#join_message").html("<span id='emconfirmchk'>회원가입 버튼을 누르시면 완료됩니다</span>");
            $("#emconfirmchk").css({
                "color" : "#0D6EFD",
                "font-weight" : "bold",
                "font-size" : "13px"
            });
            nextbtn3.style.display = 'block'
        }
    });


    // 이메일 인증번호
    $("#emailCodebtn").click(function() {
        console.log("코드발송 버튼을 누름");
       $.ajax({
          type : "POST",
          url : "/member/join/mailConfirm",
          data : {
             "email" : $("#mb_email").val()
          },
          success : function(data){
             document.getElementById('mb_email').readOnly=true;
             alert("BankYam : 해당 이메일로 인증번호를 발송하였습니다")
             console.log("data : "+ data);
             form.emailCode.focus();
             emailCodeBtn.style.display = 'none';
             $("#emailCodeVs").val(data);
          }
       })
    });


</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 주소찾기
    const mb_addr = document.getElementById("mb_addr")
    mb_addr.addEventListener("click", function(){
        new daum.Postcode({
            oncomplete: function(data) {
                mb_addr.value = data.address;
                form.mb_daddr.focus();
            }
        }).open();
    });
</script>

