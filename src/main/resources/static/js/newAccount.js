$(document).ready(function(){
    // 계좌별칭 갯수를 이용하여 현재 총 계좌 갯수 구하기
    var acCount = $(".ac-name-receptor2").length;
    if(acCount >= 10){
        setPtagNacRed("계좌는 최대 10개까지만 개설 가능(해지 계좌 포함)", "naC3", ".nac-psC-pTag3");
    }

    // 상품 선택으로 계좌별칭 가져오기 ajax
    // 1) 처음 페이지 진입 시 한번 가져오기
    checkPdName(acCount);
    // 2) 셀렉트 변경 시마다 가져오기
    $('#pd_named').change(function() {
        $("input.ac-name-receptor2").remove();
        checkPdName(acCount);
    });

    // 계좌별칭 입력 창해당 별칭과 동일한 계좌별칭을 가지고 있는지 체크
    $("#ac_name").on("keyup", function(){
        acNameCheck();
    });

    // 계좌 비밀번호 입력 시 숫자 인지 체크
    $("#ac_pwd").on("keyup", function(){
        if(isNaN($("#ac_pwd").val())){
            $("p.naC1").remove();
            setPtagNacRed("입력은 숫자만 가능합니다", "naC1", ".nac-psC-pTag1");
        }else if($("#ac_pwd").val().replace(/\s/g,"").length < 4){
            $("p.naC1").remove();
            setPtagNacRed("공백은 포함할 수 없습니다", "naC1", ".nac-psC-pTag1");
        }else if($("#ac_pwd").val().length == 4){
            $("p.naC1").remove();
            setPtagNac("비밀번호 설정가능", "naC1", ".nac-psC-pTag1");
        }else{
            $("p.naC1").remove(); $("p.naC2").remove();
        }

        if($("#ac_pwd").val().length == 4 && $("#ac_pwd2").val().length == 4 && $("p.naC1").text()=="비밀번호 설정가능"){
            $("p.naC2").remove();
            if($("#ac_pwd").val() == $("#ac_pwd2").val()){
                setPtagNac("비밀번호 설정가능", "naC2", ".nac-psC-pTag2");
            }else{
                setPtagNacRed("입력하신 비밀번호와 다릅니다", "naC2", ".nac-psC-pTag2");
            }
        }
    });

    // 계좌 비밀번호 확인 입력 체크
    $("#ac_pwd2").on("keyup", function(){
        if(isNaN($("#ac_pwd2").val())){
            $("p.naC2").remove();
            setPtagNacRed("입력은 숫자만 가능합니다", "naC2", ".nac-psC-pTag2");
        }else if($("#ac_pwd2").val().replace(/\s/g,"").length < 4){
            $("p.naC2").remove();
            setPtagNacRed("공백은 포함할 수 없습니다", "naC2", ".nac-psC-pTag2");
        }else if($("#ac_pwd2").val().length == 4){
            $("p.naC2").remove();
            if($("#ac_pwd2").val() == $("#ac_pwd").val() && $("p.naC1").text()=="비밀번호 설정가능"){
                setPtagNac("비밀번호 설정가능", "naC2", ".nac-psC-pTag2");
            }else if($("#ac_pwd2").val() == $("#ac_pwd").val() && $("p.naC1").text()!="비밀번호 설정가능"){
                setPtagNacRed("비밀번호를 다시 확인해 주세요", "naC2", ".nac-psC-pTag2");
            }else{
                setPtagNacRed("입력하신 비밀번호와 다릅니다", "naC2", ".nac-psC-pTag2");
            }
        }else{
            $("p.naC2").remove();
        }
    });
});

function checkPdName(acCount){
    $.ajax({
        url: "../accountM/account_pdAjax",
        type: "POST",
        data: {pd_name: $("#pd_named").val()},
        success: function(acNames){
            if(acNames == null){
                alert("알 수 없는 문제가 발생하였습니다");
                history.back();
            }else{
                $("#ac_name").val(acNames[0]);
                if(acNames[1] != null){
                    for(var i=1; i<acNames.length; i++){
                        hiddenInput = $("<input>").attr({type: "hidden", value: acNames[i]}).addClass("ac-name-receptor2");
                        $(".nac-row-block").append(hiddenInput);
                    }
                }
                acNameCheck(acCount);
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}

function acNameCheck(){
    var acNameVs = $("#ac_name").val();
    var acCount = $(".ac-name-receptor2").length;
    var isCheck = false;
    if(acCount > 0){
        var acNameGroupList = new Array(acCount);
        for(var i=0; i<acCount; i++){
            acNameGroupList[i] = $(".ac-name-receptor2").eq(i).val();
            if(acNameVs == acNameGroupList[i]){
                isCheck = true;
            }
        }
    }
    if(trim(acNameVs).length == 0){
        $("p.naC0").remove();
        setPtagNacRed("아무것도 입력하지 않으셨습니다", "naC0", ".nac-psC-pTag0");
    }else if(isCheck){
        $("p.naC0").remove();
        setPtagNacRed("동일한 이름의 계좌가 있습니다", "naC0", ".nac-psC-pTag0");
    }else{
        $("p.naC0").remove();
        setPtagNac("계좌별칭 변경가능", "naC0", ".nac-psC-pTag0");
    }
}

function setPtagNac(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:#a7d3dd").addClass(getClass);
    $(getQuery).append(pTagFr);
}

function setPtagNacRed(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:red").addClass(getClass);
    $(getQuery).append(pTagFr);
}

function nacSubmit(){
    var acCount = $(".ac-name-receptor").length;
    if(acCount >= 10){
        alert("더이상 계좌 개설이 불가합니다");
        return false;
    }else if($("p.naC0").text() != "계좌별칭 변경가능"){
        alert("계좌별칭을 다시 확인 부탁드립니다");
        return false;
    }else if($("p.naC1").text() != "비밀번호 설정가능"){
        alert("비밀번호를 다시 확인 부탁드립니다");
        return false;
    }else if($("p.naC2").text() != "비밀번호 설정가능"){
        alert("비밀번호를 다시 확인 부탁드립니다");
        return false;
    }else if(acCount < 10 && $("p.naC0").text() == "계좌별칭 변경가능" && $("p.naC1").text() == "비밀번호 설정가능" && $("p.naC2").text() == "비밀번호 설정가능"){
        $("option:selected.pd-option").val($("option:selected").attr("id"));
        document.nacf.submit();
    }else{
        alert("뭔진 모르지만 그거 안돼요..");
        return false;
    }
}