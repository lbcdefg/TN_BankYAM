$(document).ready(function(){
    // 페이지 진입 시 주 계좌 찾아서 라디오 버튼 체크해주기
    var acMainLength = $(".acm").length;
    for(var i=0; i<acMainLength; i++){
        if($(".acm").eq(i).text() == '주'){
            var acMainId = $(".acm").eq(i).attr("id");
            $("#"+acMainId).addClass("color-fb8b00");
            $("#acr-"+acMainId).attr("checked",true);
        }
    }

    $("html").click(function(e) {
        if($(e.target).is($(".acs-nameM"))){
            modifyCancel();
        }else if($(e.target).is($(".acs-psM"))){
            psCancel();
        }
    });

    // 주 계좌 변경 설정
    $(".acs-list-table input").click(function() {
        var acrConfirm = confirm("주 계좌를 변경하시겠습니까?");
        if(acrConfirm){
            var acMainId = $("input[type=radio]:checked").attr("id");
            var ac_seq = acMainId.substring(4);
            location.href="accounts?ac_seq="+ac_seq+"&cat=acM";
        }else{
            return false;
        }
    });

    // 계좌별칭 변경 창에서 키 입력시 마다 해당 별칭과 동일한 계좌별칭을 가지고 있는지 체크
    $(".ac-name").on("keyup", function(){
        var acNameGroup = $(".acn").length;
        var acNameGroupList = new Array(acNameGroup);
        var acNameVs = $(".ac-name").val();
        var isCheck = false;
        for(var i=0; i<acNameGroup; i++){
            acNameGroupList[i] = $(".acn").eq(i).text();
            if(acNameVs == acNameGroupList[i]){
                isCheck = true;
            }
        }
        if(trim(acNameVs).length == 0){
            $("p.acC").remove();
            setPtagAcs("아무것도 입력하지 않으셨습니다", "acC", ".acs-nameM-ps");
        }else if(isCheck){
            $("p.acC").remove();
            setPtagAcs("동일한 이름의 계좌가 있습니다", "acC", ".acs-nameM-ps");
        }else{
            $("p.acC").remove();
            setPtagAcs("계좌별칭 변경가능", "acC", ".acs-nameM-ps");
        }
    });

    // 기존 비밀번호 입력 시 숫자 인지 체크
    $(".ac-ps").on("keyup", function(){
        if(isNaN($(".ac-ps").val())){
            $("p.acC1").remove();
            setPtagAcs("입력은 숫자만 가능합니다", "acC1", ".acs-psM-ps1");
        }else if($(".ac-ps").val().replace(/\s/g,"").length < 4){
            $("p.acC1").remove();
            setPtagAcs("공백은 포함할 수 없습니다", "acC1", ".acs-psM-ps1");
        }else{
            $("p.acC1").remove();
            setPtagAcs("확인가능", "acC1", ".acs-psM-ps1");
        }
    });

    // 신규 비밀번호 입력 시 비밀번호 확인과 같은지 체크
    $(".ac-newPs").on("keyup", function(){
        if(isNaN($(".ac-newPs").val())){
            $("p.acC2").remove();
            setPtagAcs("입력은 숫자만 가능합니다", "acC2", ".acs-psM-ps2");
         }else if($(".ac-newPs").val().replace(/\s/g,"").length < 4){
            $("p.acC2").remove();
            setPtagAcs("공백은 포함할 수 없습니다", "acC2", ".acs-psM-ps2");
        }else if($(".ac-newPs").val().length == 4){
            $("p.acC2").remove();
            if($(".ac-ps").val() == $(".ac-newPs").val()){
                setPtagAcs("기존 비밀번호와 동일합니다", "acC2", ".acs-psM-ps2");
            }else{
                setPtagAcs("비밀번호 변경가능", "acC2", ".acs-psM-ps2");
            }
        }else{
            $("p.acC2").remove(); $("p.acC3").remove();
        }

        if($(".ac-newPs").val().length == 4 && $(".ac-newPs-check").val().length == 4 && $("p.acC2").text()=="비밀번호 변경가능"){
            $("p.acC3").remove();
            if($(".ac-newPs-check").val() == $(".ac-newPs").val()){
                setPtagAcs("비밀번호 변경가능", "acC3", ".acs-psM-ps3");
            }else{
                setPtagAcs("입력하신 비밀번호와 다릅니다", "acC3", ".acs-psM-ps3");
            }
        }
    });

    // 신규 비밀번호 확인 입력 시 기존 비밀번호와 같은지 체크
    $(".ac-newPs-check").on("keyup", function(){
        if(isNaN($(".ac-newPs-check").val())){
            $("p.acC3").remove();
            setPtagAcs("입력은 숫자만 가능합니다", "acC3", ".acs-psM-ps3");
        }else if($(".ac-newPs-check").val().replace(/\s/g,"").length < 4){
            $("p.acC3").remove();
            setPtagAcs("공백은 포함할 수 없습니다", "acC3", ".acs-psM-ps3");
        }else if($(".ac-newPs-check").val().length == 4){
            $("p.acC3").remove();
            if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()=="비밀번호 변경가능"){
                setPtagAcs("비밀번호 변경가능", "acC3", ".acs-psM-ps3");
            }else if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()!="비밀번호 변경가능"){
                setPtagAcs("재설정 비밀번호를 다시 확인해 주세요", "acC3", ".acs-psM-ps3");
            }else{
                setPtagAcs("입력하신 비밀번호와 다릅니다", "acC3", ".acs-psM-ps3");
            }
        }else{
             $("p.acC3").remove();
         }
    });
});

function setPtagAcs(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:#a7d3dd").addClass(getClass);
    $(getQuery).append(pTagFr);
}

// 계좌별칭 수정버튼 눌렀을 때
function modifyName(name, seq){
    $(".ac-receptor").attr("id", seq);
    $(".ac-name").val(name);
    $(".ac-receptor").val($(".ac-name").val());
    $(".ac-receptor2").val(seq);
    toggleNameM($(".acs-nameM"));
}

// 계좌별칭 mini창 여는 클래스 설정
function toggleNameM(nameM) {
    nameM.toggleClass("show-acs-nameM");
}

// 계좌별칭 수정창에서 변경 버튼 클릭 시
function modifySubmit(){
    if($("p.acC").text() == "계좌별칭 변경가능"){
        document.acnf.submit();
    }else{
        return false;
    }
}

// 계좌별칭 수정창에서 취소 버튼 클릭 시
function modifyCancel(){
    if($(".ac-receptor").val() == $(".ac-name").val()){
        toggleNameM($(".acs-nameM"));
    }else{
        var changeTextResult = confirm("작성중인 내용을 취소하시겠습니까?");
        if(changeTextResult){
            $("p.acC").remove();
            toggleNameM($(".acs-nameM"));
        }else{
            return false;
        }
    }
}


// 비밀번호 변경 버튼 클릭시
function modifyPs(seq){
    $(".ac-receptor").attr("id", seq);
    $(".ac-receptor2").val(seq); $(".ac-receptor3").val(seq);
    togglePsM($(".acs-psM"));
}

// 비밀번호 변경 mini창 여는 클래스 설정
function togglePsM(psM) {
    psM.toggleClass("show-acs-psM");
}


// 비밀번호 변경창에서 기존 비밀번호 확인 버튼 클릭 시
function psCheck(){
    var ac_ps = $(".ac-ps").val();
    if(isNaN(ac_ps)){
        alert("비밀번호는 숫자만 입력해 주세요");
        return false;
    }else if($(".ac-ps").val().replace(/\s/g,"").length < 4){
        alert("공백을 포함할 수 없습니다");
        return false;
    }else if(ac_ps.length != 4){
        alert("4자리의 비밀번호를 입력해 주세요");
        return false;
    }else if(!isNaN(ac_ps) && ac_ps.length == 4){
        psCheckAjax(ac_ps);
    }else{
        alert("뭔진 모르지만 그거 안돼요..");
        return false;
    }
}

// 기존 비밀번호 체크 Ajax
function psCheckAjax(ac_ps){
    var ac_seq = $(".ac-receptor2").val();
    alert(ac_seq);
    alert(ac_ps);
    $.ajax({
        url: "../accountM/accounts_psCheck",
        type: "POST",
        data: {ac_seq: ac_seq, ac_ps: ac_ps},
        success: function(check){
            alert(check);
            if(check == "allow"){
                $("p.acC1").remove();
                setPtagAcs("비밀번호 확인완료", "acC1", ".acs-psM-ps1");
                $(".ac-ps").attr("disabled",true);
                $(".ac-newPs").attr("disabled",false);
                $(".ac-newPs-check").attr("disabled",false);
            }else if(check == "0"){
                $("p.acC1").remove();
                setPtagAcs("비밀번호 확인 5회 실패... 뱅크얌으로 문의주세요 (02-1234-1234)", "acC1", ".acs-psM-ps1");
            }else if(check == "cancel"){
                $("p.acC1").remove();
                setPtagAcs("잘못된 경로, 혹은 문제가 발생.. 뱅크얌으로 문의주세요 (02-1234-1234)", "acC1", ".acs-psM-ps1");
            }else{
                $("p.acC1").remove();
                setPtagAcs("비밀번호 확인 실패.. " + check + "회 남음.", "acC1", ".acs-psM-ps1");
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}

// 비밀번호 변경창에서 변경 버튼 클릭 시
function psSubmit(){
    if($("p.acC1").text() == "비밀번호 확인완료" && $("p.acC2").text() == "비밀번호 변경가능" && $("p.acC3").text() == "비밀번호 변경가능"){
        document.acpf.submit();
    }else{
        alert("비밀번호 변경 내용을 다시 확인해주세요");
        return false;
    }
}

// 비밀번호 변경창에서 취소 버튼 클릭 시
function psCancel(){
    var psMResult = confirm("비밀번호 변경을 취소하시겠습니까?");
    if(psMResult){
        $("p.acC1").remove(); $("p.acC2").remove(); $("p.acC3").remove();
        $(".ac-ps").val("");
        $(".ac-newPs").val("");
        $(".ac-newPs-check").val("");
        togglePsM($(".acs-psM"));
        $(".ac-ps").attr("disabled",false);
        $(".ac-newPs").attr("disabled",true);
        $(".ac-newPs-check").attr("disabled",true);
    }else{
        return false;
    }
}