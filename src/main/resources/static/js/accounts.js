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
        pTagFrO = $("<p>").text("변경가능합니다.").attr("style", "color:#a7d3dd").addClass("acC");
        pTagFrX = $("<p>").text("동일한 이름의 계좌가 있습니다.").attr("style", "color:#a7d3dd").addClass("acC");
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
        if(isCheck){
            $("p.acC").remove();
            $(".acs-nameM-ps").append(pTagFrX);
        }else{
            $("p.acC").remove();
            $(".acs-nameM-ps").append(pTagFrO);
        }
    });

    // 기존 비밀번호 입력 시 기존 비밀번호와 같은지 체크
    $(".ac-ps").on("keyup", function(){
        if(isNaN($(".ac-ps").val())){
            $("p.acC1").remove();
            setPtagAcs("입력은 숫자만 가능합니다", "acC1", ".acs-psM-ps1");
        }else{
            $("p.acC1").remove();
        }
    });

    // 신규 비밀번호 입력 시 기존 비밀번호와 같은지 체크
    $(".ac-newPs").on("keyup", function(){
        if($(".ac-newPs").val().length == 4){
            $("p.acC2").remove();
            if($(".ac-ps").val() == $(".ac-newPs").val()){
                pTagFrX = $("<p>").text("기존 비밀번호와 동일합니다").attr("style", "color:#a7d3dd").addClass("acC2");
                $(".acs-psM-ps2").append(pTagFrX);
            }else{
                pTagFrO = $("<p>").text("비밀번호 변경가능").attr("style", "color:#a7d3dd").addClass("acC2");
                $(".acs-psM-ps2").append(pTagFrO);
            }
        }else{
            $("p.acC2").remove();
            $("p.acC3").remove();
        }

        if($(".ac-newPs").val().length == 4 && $(".ac-newPs-check").val().length == 4 && $("p.acC2").text()=="비밀번호 변경가능"){
            $("p.acC3").remove();
            if($(".ac-newPs-check").val() == $(".ac-newPs").val()){
                pTagFrOO = $("<p>").text("비밀번호 변경가능").attr("style", "color:#a7d3dd").addClass("acC3");
                $(".acs-psM-ps3").append(pTagFrOO);
            }else{
                pTagFrXX = $("<p>").text("입력하신 비밀번호와 다릅니다.").attr("style", "color:#a7d3dd").addClass("acC3");
                $(".acs-psM-ps3").append(pTagFrXX);
            }
        }
    });

    // 비밀번호 체크 시 기존 비밀번호와 같은지 체크
    $(".ac-newPs-check").on("keyup", function(){
        if($(".ac-newPs-check").val().length == 4){
            $("p.acC3").remove();
            if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()=="비밀번호 변경가능"){
                pTagFrO = $("<p>").text("비밀번호 변경가능").attr("style", "color:#a7d3dd").addClass("acC3");
                $(".acs-psM-ps3").append(pTagFrO);
            }else if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()!="비밀번호 변경가능"){
                pTagFrO = $("<p>").text("신규 비밀번호를 다시 확인해 주세요.").attr("style", "color:#a7d3dd").addClass("acC3");
                $(".acs-psM-ps3").append(pTagFrO);
            }else{
                pTagFrX = $("<p>").text("입력하신 비밀번호와 다릅니다.").attr("style", "color:#a7d3dd").addClass("acC3");
                $(".acs-psM-ps3").append(pTagFrX);
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

function windowOnClick(target) {
    if (target === $(".acs-nameM")) {
        alert("들어는 오냐?");
        toggleNameM($(".acs-nameM"));
    }
}

function toggleNameM(nameM) {
    nameM.toggleClass("show-acs-nameM");
}

// 계좌별칭 수정창에서 변경 버튼 클릭 시
function modifySubmit(){
    if($("p.acC").text() == "변경가능합니다."){
        document.acnf.submit();
    }else{
        $("p.acC").remove();
        pTagFrC = $("<p>").text("동일한 이름의 계좌로는 변경할 수 없습니다.").attr("style", "color:#fb8b00").addClass("acC");
        $(".acs-nameM-ps").append(pTagFrC);
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


// 비밀번호 변경창 열림
function modifyPs(seq){
    $(".ac-receptor").attr("id", seq);
    $(".ac-receptor2").val(seq);
    $(".ac-receptor3").val(seq);
    togglePsM($(".acs-psM"));
}

function togglePsM(psM) {
    psM.toggleClass("show-acs-psM");
}


// 비밀번호 변경창에서 기존 비밀번호 확인 버튼 클릭 시
function psCheck(){
    var ac_ps = $(".ac-ps").val();
    if(isNaN(ac_ps)){
        alert("비밀번호는 숫자만 입력해 주세요.");
        return false;
    }else if(ac_ps.length != 4){
        alert("4자리의 비밀번호를 입력해 주세요.");
        return false;
    }else if(!isNaN(ac_ps) && ac_ps.length == 4){
        psCheckAjax(ac_ps);
    }else{
        alert("뭔진 모르지만 그거 안돼요..");
        return false;
    }
}

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
                $(".ac-ps").attr("readonly", true);
                $("p.acC1").remove();
                setPtagAcs("비밀번호 확인 완료", "acC1", ".acs-psM-ps1");
            }else if(check == "cancel"){
                $("p.acC1").remove();
                setPtagAcs("비밀번호가 다릅니다.", "acC1", ".acs-psM-ps1");
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}

// 비밀번호 변경창에서 취소 버튼 클릭 시
function psCancel(){
    var psMResult = confirm("비밀번호 변경을 취소하시겠습니까?");
    if(psMResult){
        $("p.acC1").remove();
        $("p.acC2").remove();
        $("p.acC3").remove();
        $(".ac-ps").val("");
        $(".ac-newPs").val("");
        $(".ac-newPs-check").val("");
        togglePsM($(".acs-psM"));
    }else{
        return false;
    }
}