$(document).ready(function(){
    var acMainName = $(".acm").attr("name");
    alert(acMainName);
    if(acMainName == '주'){
        var acMainId = $(".acm").attr("id");
        $("#"+acMainId).addClass("color-fb8b00");
        $("#acr-"+acMainId).attr("checked",true);
    }

    $(".acs-list-table input").click(function() {
        var acrConfirm = confirm("주 계좌를 변경하시겠습니까?");
        if(acrConfirm){
            var acMainId = $("input[type=radio]:checked").attr("id");
            var ac_seq = acMainId.substring(5);
            alert(ac_seq);
            location.href="accounts?ac_seq+"+ac_seq+"&cat=acM";
        }else{
            return false;
        }
    });
});