

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

function checkPwd(){
    var pwd1 = document.getElementById('ac_pwd1').value;
    var pwd2 = document.getElementById('ac_pwd2').value;

    if(pwd1 != pwd2){
        alert("비밀번호가 일치하지않습니다");
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
                console.log(isPwdChecked);
            }else{
                $("#alert-success").hide();
                $("#alert-danger").show();
                $("#submit").attr("disabled", "disabled");
                isPwdChecked = false;
                console.log(isPwdChecked);
            }
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
            alert(JSON.stringify(data));
            var dataChange = JSON.stringify(data);
            $("#ac-balance-check").text(data.ac_balance);
        },
        error: function(error){
            console.log("error: " + error);
        }
    });
}

