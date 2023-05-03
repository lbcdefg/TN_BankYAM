$("document").ready(function(){
    var ac_seq = $("#ac_seq").val();
    if(ac_seq != "계좌 선택"){
        checkBalance(ac_seq);
    }
});

function count(type)  {
    // 결과를 표시할 element
    var resultElement = document.getElementById('result');
    // 현재 화면에 표시된 값
    var number = $('#result').val();
    if(number==null || number==""){
        number=0;
    }

    console.log(number);
    console.log(resultElement);
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

function checkPwd(){
    var pwd1 = document.getElementById('ac_pwd1').value;
    var pwd2 = document.getElementById('ac_pwd2').value;
    if(pwd1 != pwd2){
        alert("비밀번호가 일치하지 않습니다");
        return false;
    } else {
        alert("비밀번호가 일치합니다");
        return true;
    }
}


$(function(){
    var isPwdChecked;
    $("#alert-success").hide();
    $("#alert-danger").hide();
    $("input").keyup(function(){
        var pwd1=$("#password_1").val();
        var pwd2=$("#password_2").val();
        if(pwd1 != "" || pwd2 != ""){
            if(pwd1 == pwd2){
                $("#alert-success").show();
                $("#alert-danger").hide();
                $("#submit").removeAttr("disabled");
                isPwdChecked = true;
            }else{
                $("#alert-success").hide();
                $("#alert-danger").show();
                $("#submit").attr("disabled", "disabled");
                isPwdChecked = false;
            }
        }
    });
});

$(function(){
    var isNullChecked;
    $("#alert-notnull").hide();
    $("#alert-null").hide();
    $("input").keyup(function(){
        var checkingNull=$("#nuChk").val();
        if(checkingNull != ""){
            $("#alert-notnull").show();
            $("#alert-null").hide();
            $("#submit").removeAttr("disabled");
            isNullChecked = true;

        }else if(checkingNull == ""){
            $("#alert-notnull").hide();
            $("#alert-null").show();
            $("#submit").attr("disabled", "disabled");
            isNullChecked = false;
        }
    });
});

function checkBalance(ac_seq){
    var data = {};
    var ac_seq = document.getElementById('ac_seq').value;
    $.ajax({
        url: "checkBalance",
        type: "GET",
        data: {ac_seq: ac_seq},
        success: function(data){
            var dataChange = JSON.stringify(data);
            $("#ac-balance-check").text(data.ac_balance);
        },
        error: function(error){
            console.log("error: " + error);
        }
    });
}


function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }
}

function compare(){
    var balanceMoney = Number(document.getElementById("ac-balance-check").innerText);
    var amount = Number(document.getElementById("result").value);
    console.log(balanceMoney);
    console.log(amount);
    if(balanceMoney>=amount){
        return true;

    }else if(balanceMoney<amount){
        return false;
    }
}

function nextPage(){
    var amount = Number(document.getElementById("result").value);
    if(document.getElementById("nuChk").value==""){
        alert("보내실 계좌는 필수 입력입니다.");
        return;
    }
    if(document.getElementById("result").value==0 || document.getElementById("result").value<0){
        alert("이체 금액을 다시 한 번 확인해주세요.");
        return;
    }
    if(compare()){
        f.submit();
    }else{
        alert("금액을 다시 한 번 확인해주세요.");
        return;
    }
}
