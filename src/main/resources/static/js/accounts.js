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

    window.addEventListener("click", windowOnClick);

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
        pTagFrO = $("<p>").text("변경가능합니다.").attr("style", "color:#F7F3EF").addClass("acC");
        pTagFrX = $("<p>").text("동일한 이름의 계좌가 있습니다.").attr("style", "color:#F7F3EF").addClass("acC");
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
});

// 계좌별칭 수정버튼 눌렀을 때
function modifyName(name, seq){
    $(".ac-receptor").attr("id", seq);
    $(".ac-name").val(name);
    $(".ac-receptor").val($(".ac-name").val());
    $(".ac-receptor2").val(seq);
    toggleNameM($(".acs-nameM"));
}

function windowOnClick(event) {
    if (event.target === $(".acs-nameM")) {
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
        pTagFrC = $("<p>").text("동일한 이름의 계좌로는 변경할 수 없습니다.").attr("style", "color:#F7F3EF").addClass("acC");
        $(".acs-nameM-ps").append(pTagFrC);
    }
}

// 계좌별칭 수정창에서 취소 버튼 클릭 시
function modifyCancle(){
    if($(".ac-receptor").val() == $(".ac-name").val()){
        toggleNameM($(".acs-nameM"));
    }else{
        var changeTextResult = confirm("작성중인 내용을 취소하시겠습니까?");
        if(changeTextResult){
            toggleNameM($(".acs-nameM"));
        }else{
            return false;
        }
    }
}