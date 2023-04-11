$(document).ready(function(){
    $('#searchFr').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == '13'){
            checkFrSearch();
        }
    });
});

function checkFrSearch(){
    $.ajax({
        url: "../friend/friends_searchFr",
        type: "POST",
        data: {text: $("#searchFr").val()},
        success: function(membery){
            var searchDiv = $('.frs-findFr');
            if(membery.mb_seq == null){
                var pTagFr1 = $('<p>').text("찾으시는 친구가 없습니다");
                var pTagFr2 = $('<p>').text("Email 또는 계좌번호를 정확하게 입력해 주세요");
                searchDiv.append(pTagInsert1);
                searchDiv.append(pTagInsert2);
                pTagInsert1.addClass("noSearchP1");
                pTagInsert2.addClass("noSearchP2");
            }else if(membery.mb_seq != null && membery.mb_imagepath == null){
                var imgTagFr = $("<img>").attr("src", "/css/imgs/BankYamChracter.png");
                var pTagFrName = $('<p>').text(membery.mb_name);
                searchDiv.append(imgTagFr);
                searchDiv.append(pTagFr1);
                imgTagFr.addClass("frs-img-profile");
                pTagFrName.addClass("frs-name-profile");
            }else{
                var imgTagFr = $("<img>").attr("src", membery.mb_imagepath);
                var pTagFrName = $('<p>').text(membery.mb_name);
                searchDiv.append(imgTagFr);
                searchDiv.append(pTagFr1);
                imgTagFr.addClass("frs-img-profile");
                pTagFrName.addClass("frs-name-profile");
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}