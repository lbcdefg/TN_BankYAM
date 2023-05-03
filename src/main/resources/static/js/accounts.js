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
        }else if($(e.target).is($(".acs-psC"))){
            psCCancel();
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
            setPtagAcsRed("아무것도 입력하지 않으셨습니다", "acC", ".acs-nameM-ps");
        }else if(isCheck){
            $("p.acC").remove();
            setPtagAcsRed("동일한 이름의 계좌가 있습니다", "acC", ".acs-nameM-ps");
        }else{
            $("p.acC").remove();
            setPtagAcs("계좌별칭 변경가능", "acC", ".acs-nameM-ps");
        }
    });

    // 기존 비밀번호 입력 시 숫자 인지 체크
    $(".ac-ps").on("keyup", function(){
        if(isNaN($(".ac-ps").val())){
            $("p.acC1").remove();
            $("p.acD").remove();
            setPtagAcsRed("입력은 숫자만 가능합니다", "acC1", ".acs-psM-ps1");
        }else if($(".ac-ps").val().replace(/\s/g,"").length < 4){
            $("p.acC1").remove();
            $("p.acD").remove();
            setPtagAcsRed("공백은 포함할 수 없습니다", "acC1", ".acs-psM-ps1");
        }else{
            $("p.acC1").remove();
            $("p.acD").remove();
            setPtagAcs("확인가능", "acC1", ".acs-psM-ps1");
        }
    });

    // 신규 비밀번호 입력 시 비밀번호 확인과 같은지 체크
    $(".ac-newPs").on("keyup", function(){
        if(isNaN($(".ac-newPs").val())){
            $("p.acC2").remove();
            setPtagAcsRed("입력은 숫자만 가능합니다", "acC2", ".acs-psM-ps2");
         }else if($(".ac-newPs").val().replace(/\s/g,"").length < 4){
            $("p.acC2").remove();
            setPtagAcsRed("공백은 포함할 수 없습니다", "acC2", ".acs-psM-ps2");
        }else if($(".ac-newPs").val().length == 4){
            $("p.acC2").remove();
            if($(".ac-ps").val() == $(".ac-newPs").val()){
                setPtagAcsRed("기존 비밀번호와 동일합니다", "acC2", ".acs-psM-ps2");
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
                setPtagAcsRed("입력하신 비밀번호와 다릅니다", "acC3", ".acs-psM-ps3");
            }
        }
    });

    // 신규 비밀번호 확인 입력 시 기존 비밀번호와 같은지 체크
    $(".ac-newPs-check").on("keyup", function(){
        if(isNaN($(".ac-newPs-check").val())){
            $("p.acC3").remove();
            setPtagAcsRed("입력은 숫자만 가능합니다", "acC3", ".acs-psM-ps3");
        }else if($(".ac-newPs-check").val().replace(/\s/g,"").length < 4){
            $("p.acC3").remove();
            setPtagAcsRed("공백은 포함할 수 없습니다", "acC3", ".acs-psM-ps3");
        }else if($(".ac-newPs-check").val().length == 4){
            $("p.acC3").remove();
            if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()=="비밀번호 변경가능"){
                setPtagAcs("비밀번호 변경가능", "acC3", ".acs-psM-ps3");
            }else if($(".ac-newPs-check").val() == $(".ac-newPs").val() && $("p.acC2").text()!="비밀번호 변경가능"){
                setPtagAcsRed("재설정 비밀번호를 다시 확인해 주세요", "acC3", ".acs-psM-ps3");
            }else{
                setPtagAcsRed("입력하신 비밀번호와 다릅니다", "acC3", ".acs-psM-ps3");
            }
        }else{
             $("p.acC3").remove();
         }
    });

    // 비밀번호 확인 창 입력 시 숫자 인지 체크
    $(".ac-ps-check").on("keyup", function(){
        if(isNaN($(".ac-ps-check").val())){
            $("p.acCC1").remove();
            $("p.acD").remove();
            setPtagAcsRed("입력은 숫자만 가능합니다", "acCC1", ".acs-psC-ps1");
        }else if($(".ac-ps-check").val().replace(/\s/g,"").length < 4){
            $("p.acCC1").remove();
            $("p.acD").remove();
            setPtagAcsRed("공백은 포함할 수 없습니다", "acCC1", ".acs-psC-ps1");
        }else{
            $("p.acCC1").remove();
            $("p.acD").remove();
            setPtagAcs("확인가능", "acCC1", ".acs-psC-ps1");
        }
    });

    // 윈도우 width 체크해서 form 변경해줄 코드
    var windowWidth = $(window).width();
    if(windowWidth<900){
        $(".ac-change-frame2").show();
        $(".ac-change-frame1").hide();
    }else{
        $(".ac-change-frame2").hide();
        $(".ac-change-frame1").show();
    }

    // 윈도우 size 변경 시 width 체크해서 form 변경해줄 코드
    $(window).resize(function(){
        if(this.resizeTO){
            clearTimeout(this.resizeTO);
        }
        this.resizeTO = setTimeout(function(){
            $(this).trigger('resizeEnd');
        });
    });

    $(window).on('resizeEnd', function(){
        windowWidth = $(window).width();
        if(windowWidth<900){
            $(".ac-change-frame2").show();
            $(".ac-change-frame1").hide();
        }else{
            $(".ac-change-frame2").hide();
            $(".ac-change-frame1").show();
        }
    });

    // 1) 처음 페이지 진입 시 한번 가져오기
    selectGetAc();

    // 2) 셀렉트 변경 시마다 가져오기
    $('.ac-manage-select-content').change(function() {
        selectGetAc();
    });
});

function setPtagAcs(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:#a7d3dd").addClass(getClass);
    $(getQuery).append(pTagFr);
}

function setPtagAcsRed(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:red").addClass(getClass);
    $(getQuery).append(pTagFr);
}

// 계좌별칭 수정버튼 눌렀을 때
function modifyName(name, seq){
    $(".ac-receptor1").attr("id", seq);
    $(".ac-name").val(name);
    $(".ac-receptor1").val($(".ac-name").val());
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
    if($(".ac-receptor1").val() == $(".ac-name").val()){
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
    $(".ac-receptor").val(seq);
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

// 기존 비밀번호 체크 Ajax -> 비밀번호 변경창용
function psCheckAjax(ac_ps){
    var ac_seq = $(".ac-receptor").val();
    $.ajax({
        url: "../accountM/accounts_psCheck",
        type: "POST",
        data: {ac_seq: ac_seq, ac_ps: ac_ps},
        success: function(check){
            if(check == "allow"){
                $("p.acC1").remove();
                $("p.acD").remove();
                setPtagAcs("비밀번호 확인완료", "acC1", ".acs-psM-ps1");
                $(".ac-ps").attr("disabled",true);
                $(".ac-newPs").attr("disabled",false);
                $(".ac-newPs-check").attr("disabled",false);
            }else if(check == "0"){
                $("p.acC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("비밀번호 확인 5회 실패하셨습니다.. 뱅크얌으로 문의주세요 (02-1234-1234)", "acD", ".acs-psM-ps1");
            }else if(check == "cancel"){
                $("p.acC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("잘못된 경로, 혹은 문제가 발생.. 뱅크얌으로 문의주세요 (02-1234-1234)", "acC1", ".acs-psM-ps1");
            }else{
                $("p.acC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("비밀번호 확인 실패.. " + check + "회 남음.", "acC1", ".acs-psM-ps1");
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
        var psConfirm = confirm("입력하신 비밀번호로 변경하시겠습니까?");
        if(psConfirm){
            document.acpf.submit();
        }else{
            return false;
        }
    }else{
        alert("비밀번호 변경 내용을 다시 확인해주세요");
        return false;
    }
}

// 비밀번호 변경창에서 취소 버튼 클릭 시
function psCancel(){
    var psMResult = confirm("비밀번호 변경을 취소하시겠습니까?");
    if(psMResult){
        $("p.acD").remove(); $("p.acC1").remove(); $("p.acC2").remove(); $("p.acC3").remove();
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

// 해지신청, 계좌삭제 클릭시
function acCheck2(status, balSt, ac_seq, ac_balance, pdType){
    if(pdType == "적금"){
        if(ac_balance >= 0){
            delAcCheckConfirm = confirm("적금계좌는 해지 시 해지계좌로 처리되지 않고 바로 계좌가 삭제됩니다. 그래도 해지하시겠습니까?");
            if(delAcCheckConfirm){
                delAcConfirm = confirm("계좌 잔액이 " + balSt + "원 남았습니다. 해당 금액을 주 계좌로 옮기고 계좌를 삭제하시겠습니까?");
                if(delAcConfirm){
                    checkPs("삭제", ac_seq);
                }
            }
        }else{
            alert("해당 계좌의 잔액 또는 상태가 삭제할 수 없는 상태이므로 고객센터로 문의 바랍니다.");
            return false;
        }
    }else{
        if(status == "해지"){
            if(ac_balance > 0){
                delAcConfirm = confirm("계좌 잔액이 " + balSt + "원 남았습니다. 해당 금액을 주 계좌로 옮기고 계좌를 삭제하시겠습니까?");
            }else if(ac_balance == 0){
                delAcConfirm = confirm("해당 계좌엔 잔액이 없습니다. 계좌를 삭제하시겠습니까?");
            }else{
                alert("해당 계좌의 잔액 또는 상태가 삭제할 수 없는 상태이므로 고객센터로 문의 바랍니다.");
                return false;
            }
            if(delAcConfirm){
                checkPs("삭제", ac_seq);
            }
        }else if(status == "복구중"){
            reAcConfirm = confirm("현재 계좌가 복구중 상태입니다. 계좌 복구를 취소하시겠습니까?");
            if(reAcConfirm){
                acCheck("복구취소", ac_seq);
            }
        }else if(status == "해지신청"){
            outAcConfirm = confirm("계좌 잔액이 " + balSt + "원 남았습니다. 해당 계좌를 정말 해지하시겠습니까? (※ 해지계좌는 복구는 가능하지만 일정시간이 소요됩니다.)");
            if(outAcConfirm){
                checkPs("해지신청", ac_seq);
            }
        }
    }
    return false;
}

// 휴면신청/취소, 복구신청/취소 클릭시
function acCheck(check, ac_seq){
    if(check == "복구신청"){
        checkConfirm = confirm("계좌 복구를 신청하시겠습니까? 신청 시 48시간 내 복구가 처리 됩니다");
    }else if(check == "복구취소"){
        checkConfirm = confirm("계좌 복구를 취소하시겠습니까?");
    }else if(check == "휴면신청"){
        checkConfirm = confirm("해당 계좌를 휴면상태로 만드시겠습니까?");
    }else if(check == "휴면취소"){
        checkConfirm = confirm("해당 계좌의 휴면상태를 취소하시겠습니까?");
    }else{
        alert("뭔진 모르지만 그거 안돼요..");
        return false;
    }
    if(checkConfirm){
        checkPs(check, ac_seq);
    }else{
        return false;
    }
}

// 비밀번호 확인 절차
function checkPs(check, ac_seq){
    $(".ac-receptor1").val(ac_seq);
    $(".ac-receptor2").val(check);
    togglePsM($(".acs-psC"));
}

// 비밀번호 확인 mini창 여는 클래스 설정
function togglePsC(psC) {
    psM.toggleClass("show-acs-psC");
}

// 비밀번호 확인창에서 확인 버튼 클릭시
function psCCheck(){
    var ac_ps = $(".ac-ps-check").val();
    if(isNaN(ac_ps)){
        alert("비밀번호는 숫자만 입력해 주세요");
        return false;
    }else if(ac_ps.replace(/\s/g,"").length < 4){
        alert("공백을 포함할 수 없습니다");
        return false;
    }else if(ac_ps.length != 4){
        alert("4자리의 비밀번호를 입력해 주세요");
        return false;
    }else if(!isNaN(ac_ps) && ac_ps.length == 4 && $("p.acCC1").text() == "확인가능"){
        psCCheckAjax(ac_ps);
    }else{
        alert("뭔진 모르지만 그거 안돼요..");
        return false;
    }
}

// 비밀번호 확인 Ajax
function psCCheckAjax(ac_ps){
    var ac_seq = $(".ac-receptor1").val();
    var check = $(".ac-receptor2").val();
    $.ajax({
        url: "../accountM/accounts_psCheck",
        type: "POST",
        data: {ac_seq: ac_seq, ac_ps: ac_ps},
        success: function(checkAjax){
            if(checkAjax == "allow"){
                location.href="accounts_update?ac_seq=" + ac_seq + "&upCat=" + check;
            }else if(checkAjax == "0"){
                $("p.acCC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("비밀번호 확인 5회 실패하셨습니다.. 뱅크얌으로 문의주세요 (02-1234-1234)", "acD", ".acs-psC-ps1");
            }else if(checkAjax == "cancel"){
                $("p.acCC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("잘못된 경로, 혹은 문제가 발생.. 뱅크얌으로 문의주세요 (02-1234-1234)", "acCC1", ".acs-psC-ps1");
            }else{
                $("p.acCC1").remove();
                $("p.acD").remove();
                setPtagAcsRed("비밀번호 확인 실패.. " + checkAjax + "회 남음.", "acCC1", ".acs-psC-ps1");
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}

// 비밀번호 확인창에서 취소 버튼 클릭 시
function psCCancel(){
    var psCResult = confirm("계좌 비밀번호 인증을 취소하시겠습니까?");
    if(psCResult){
        $("p.acD").remove(); $("p.acC1").remove(); $("p.acC2").remove(); $("p.acC3").remove();
        $(".ac-ps-check").val("");
        togglePsM($(".acs-psC"));
    }else{
        return false;
    }
}

// window size 900 이하일 때 계좌 내용 뿌려주기
function selectGetAc(){
    $(".ac-manage-row").hide();
    var selectOptionAc = $(".ac-manage-select-content").val();
    var getAcId = "ac-" + selectOptionAc;
    $("tr#"+getAcId).show();
}

function changeMain(ac_seq){
    var acrConfirm = confirm("주 계좌를 변경하시겠습니까?");
    if(acrConfirm){
        location.href="accounts?ac_seq="+ac_seq+"&cat=acM";
    }else{
        return false;
    }
}