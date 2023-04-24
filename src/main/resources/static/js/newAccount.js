$(document).ready(function(){
    // 기존 비밀번호 입력 시 숫자 인지 체크
    $("#ac_pwd").on("keyup", function(){
        if(isNaN($("#ac_pwd").val())){
            $("p.naC1").remove();
            setPtagNac("입력은 숫자만 가능합니다", "naC1", ".nac-psC-pTag1");
        }else if($("#ac_pwd").val().replace(/\s/g,"").length < 4){
            $("p.naC1").remove();
            setPtagNac("공백은 포함할 수 없습니다", "naC1", ".nac-psC-pTag1");
        }else if($("#ac_pwd").val().length == 4){
            $("p.naC1").remove();
            setPtagNac("비밀번호 설정가능", "naC1", ".nac-psC-pTag1");
        }else{
            $("p.naC1").remove(); $("p.naC2").remove();
        }

        if($("#ac_pwd").val().length == 4 && $("#ac_pwd2").val().length == 4 && $("p.naC2").text()=="비밀번호 설정가능"){
            $("p.naC2").remove();
            if($("#ac_pwd").val() == $("#ac_pwd2").val()){
                setPtagNac("비밀번호 설정가능", "naC2", ".nac-psC-pTag2");
            }else{
                setPtagNac("입력하신 비밀번호와 다릅니다", "naC2", ".nac-psC-pTag2");
            }
        }
    });

    $("#ac_pwd2").on("keyup", function(){
        if(isNaN($("#ac_pwd2").val())){
            $("p.naC2").remove();
            setPtagNac("입력은 숫자만 가능합니다", "naC2", ".nac-psC-pTag2");
         }else if($("#ac_pwd2").val().replace(/\s/g,"").length < 4){
            $("p.naC2").remove();
            setPtagNac("공백은 포함할 수 없습니다", "naC2", ".nac-psC-pTag2");
        }else if($("#ac_pwd2").val().length == 4){
            $("p.naC2").remove();
            if($("#ac_pwd2").val() == $("#ac_pwd").val() && $("p.naC1").text()=="비밀번호 설정가능"){
                setPtagNac("비밀번호 설정가능", "naC2", ".nac-psC-pTag2");
            }else if($("#ac_pwd2").val() == $("#ac_pwd").val() && $("p.naC1").text()!="비밀번호 설정가능"){
                setPtagNac("비밀번호를 다시 확인해 주세요", "naC2", ".nac-psC-pTag2");
            }else{
                setPtagNac("입력하신 비밀번호와 다릅니다", "naC2", ".nac-psC-pTag2");
            }
        }else{
            $("p.naC2").remove();
        }
    });
});

function setPtagNac(getText, getClass, getQuery){
    pTagFr = $("<p>").text(getText).attr("style", "color:#a7d3dd").addClass(getClass);
    $(getQuery).append(pTagFr);
}