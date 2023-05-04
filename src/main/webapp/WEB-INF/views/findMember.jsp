<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body>
    <center>
        <div class="container content">
            <div class="body-row">
                <div class="col-sm-6">
                    <form id="findMemberForm" action="editPwd"  method="post">
                        <div class="login-form-container" id="findIDForm">
                            <div class="reg-header">
                                <h2>아이디찾기</h2>
                            </div>
                            <div class="row">
                                <div class="row-in">
                                    <input type="text" placeholder="가입시 사용한 전화번호를 입력하세요" class="form-control" id="mb_phone" name="mb_phone" autocomplete="off" autofocus="autofocus">
                                </div>
                            </div>
                            <div class="row">
                                <p id="findID_message"></p>
                            </div>
                            <div class="row">
                                <button id="findID_chkPhone"  type="button" class="normal-btn">조회</button>
                            </div>
                            <hr>
                            <p>회원 가입은 <a class="color-blue" href="/member/join">여기</a>에서 할 수 있습니다</p>
                            <p><a class="color-blue" href="/member/login">로그인</a> / <a class="color-blue" href="/member/findPW">비밀번호찾기</a></p>
                        </div>



                        <div class="login-form-container" id="findPWForm" >
                            <div class="reg-header">
                                <h2>비밀번호찾기</h2>
                            </div>
                            <div class="row">
                                <div class="row-in" style="margin-left:-15;">
                                    <input type="text" placeholder="이메일 주소를 입력하세요" class="form-control" id="mb_email" name="mb_email" autocomplete="off" autofocus="autofocus">
                                    <input type="text" placeholder="인증코드를 입력해주세요" class="form-control" id="emailCode" name="emailCode" autocomplete="off" autofocus="autofocus" style="display:none;">
                                    <div id="findMember_pwd" style="display:none;">
                                        <input type="password" placeholder="변경할 비밀번호를 입력하세요" class="form-control" id="mb_pwd" name="mb_pwd" autocomplete="off" autofocus="autofocus"></br>
                                        <input type="password" placeholder="비밀번호를 확인해주세요" class="form-control" id="mb_pwd2" name="mb_pwd2" autocomplete="off" autofocus="autofocus">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <p id="findPW_message"></p>
                            </div>
                            <div class="row">
                                <button id="findPW_btn" type="button" class="normal-btn">확인</button>
                            </div>
                            <hr>
                            <p>회원 가입은 <a class="color-blue" href="/member/join">여기</a>에서 할 수 있습니다</p>
                            <p><a class="color-blue" href="/member/login">로그인</a> / <a class="color-blue" href="/member/findID">아이디찾기</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </center>
</body>
<script>
        window.onload = function(){
        var url = window.location.href;
        var urlLast = url.split('/').reverse()[0];
        if(urlLast == 'findPW'){
            findIDForm.style.display = 'none';
            findPWForm.style.display = 'block';
        }else if(urlLast == 'findID'){
            findIDForm.style.display = 'block';
            findPWForm.style.display = 'none';
        }
    }
    // 페이지 로드시 url이 findPW면 비밀번호 찾기로, findID면 아이디 찾기로 뿌려주기


    // 비번확인시 입력 메일로 코드발송하기
    function sendMail(){
        $.ajax({
          type : "POST",
          url : "/member/join/mailConfirm",
          data : {
             "email" : $("#mb_email").val()
          },
          success : function(data){
             console.log("인증코드: " + data);
             code = data;
          }
       })
    }

    const codeInput = document.getElementById("emailCode");
    const pwdDiv = document.getElementById("findMember_pwd");

    function checkEmailConfirm(data, emailCode){
        $("#emailCode").on("keyup", function(){
            if (data != emailCode.val()){
                $("#findPW_message").html("<span>인증번호가 잘못되었습니다</span>");
                codeInput.style.display = 'block';
                pwdDiv.style.display = 'none';
            }else{
                $("#findPW_message").html("<span>인증번호 확인 완료</span>");
                codeInput.style.display = 'none';
                pwdDiv.style.display = 'block';
                $("#findID_message").html("<span></span>");
            }
        })
    }

    function checkEmail(str){
        console.log("checkEmail()들어옴");
        var exp = /@/g;
        if(exp.test(str)){
            $.ajax({
               type : "GET",
               url : "join/mailCheck",
               data : {email: $("#mb_email").val()},
               success : function(result){
                   if(result){
                       let emailVal = result.mb_email.split('@',2);
                       sendMail();
                       $("#findPW_message").html("<span>"+emailVal[0].slice(0,3)+"****@"+emailVal[1]+"로</span></br><span>인증코드를 발송했습니다</span></br></br><span>코드를 입력해주세요</span>");
                       mb_email.style.display = 'none';
                       emailCode.style.display = 'block';
                       return true;
                   }else{
                       $("#findPW_message").html("<span>가입내역이 없습니다</span>");
                       return false;
                   }
               }
           })
        }else{
            $("#findPW_message").html("<span>형식에 맞추어 입력해주세요</span>");
            return false;
        }
    }

    function checkPh(){
        $.ajax({
           type : "GET",
           url : "findID/phoneCheck",
           data : {phone: $("#mb_phone").val()},
           success : function(result){
               if(result){
                   let emailVal = result.mb_email.split('@',2);
                   $("#findID_message").html("<span>"+emailVal[0].slice(0,3)+"****@"+emailVal[1]+"</span>");
                   return true;
               }else{
                   $("#findID_message").html("<span>가입내역이 없습니다</span>");
                   return false;
               }
           }
       })
    }

    function checkPW(){
        var pwdVal = $("#mb_pwd").val();
        var pwd2Val = $("#mb_pwd2").val();
        if(check_byte(pwdVal)<4){
            $("#findID_message").html("<span>비밀번호가 너무 짧습니다</span>");
            return false;
        }else if(check_byte(pwdVal)>15){
            $("#findID_message").html("<span>비밀번호가 너무 깁니다</span>");
            return false;
        }else if(pwdVal.length == 0){
            $("#findID_message").html("<span>비밀번호 확인을 진행해주세요</span>");
            return false;
        }else if(pwdVal != pwd2Val){
            $("#findID_message").html("<span>두 비밀번호가 일치하지 않습니다</span>");
            return false;
        }else{
            return true;
        }
    }

    const findMemberForm = document.getElementById("findMemberForm");
    const IDForm = document.getElementById("findIDForm");
    const PWForm = document.getElementById("findPWForm");

    IDForm.addEventListener('keydown', function() {
        if(event.keyCode == 13){
            checkPh();
        }
    })
    PWForm.addEventListener('keydown', function(){
        if(event.keyCode == 13){
            if(event.target == document.getElementById("mb_email")){
                checkEmail($("#mb_email").val());
            }else if(event.target == document.getElementById("emailCode")){
                checkEmailConfirm(code, $("#emailCode"));
            }else{
                if(checkPW()){
                    findMemberForm.submit();
                    alert("비밀번호가 변경되었습니다");
                }
            }
        }
    })

    $("#findID_chkPhone").click(function() {
        checkPh();
    });

    $("#findPW_btn").click(function() {
        if($("#mb_email").css("display")=='block'){
            checkEmail($("#mb_email").val());
        }else if($("#emailCode").css("display")=='block'){
            checkEmailConfirm(code, $("#emailCode"));
        }else if($("#findMember_pwd").css("display")=='block'){
            if(checkPW()){
                findMemberForm.submit();
                alert("비밀번호가 변경되었습니다");
            }
        }
    });

    function check_byte(str){
        stringByteLength = (function(s,b,i,c){
            for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
            return b
        })(str)
        return stringByteLength
    }

</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>
