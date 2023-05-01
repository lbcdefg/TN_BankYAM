
//$("document").ready(function(){
//    var tr_ac_seq = $("#tr_ac_seq").val();
//    if(tr_ac_seq != "계좌선택"){
//        checkTrSearchAjax(tr_ac_seq);
//    }
//});
//
//function checkTrSearchAjax(){
//    var data = {};
//    var tr_ac_seq = document.getElementById('tr_ac_seq').val();
//    $.ajax({
//        url:"/trListSearch",
//        type: "GET",
//        data: {tr_ac_seq: tr_ac_seq},
//        success: function(data){
//            var dataChange = JSON.stringify(data);
//            $("#tr-search").text(data);
//            console.log(data);
//            alert(data);
//        },
//        error: function(error){
//            alert("error:"+error);
//        }
//    });
//}
