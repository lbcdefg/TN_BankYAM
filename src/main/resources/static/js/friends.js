$(document).ready(function(){
    $('#searchFr').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == "13"){
            checkFrSearch();
        }
    });
    $(".frs-plus-btn").click(function(){
        var resultAddReq = confirm($(".frs-name-profile").text()+"님에게 친구추가를 요청하시겠습니까?");
        if(resultAddReq){
            var frId = $(".frs-send-btn").attr("id")
            location.href="/friend/friends_AddFr?frId=" + frId + "&catAdd=reqAdd";
        }else{
            return false;
        }
    });
    $(".frs-block-btn").click(function(){
        var resultBlFr = confirm($(".frs-name-profile").text()+"님을 차단하시겠습니까?");
        if(resultBlFr){
            var frId = $(".frs-send-btn").attr("id")
            location.href="/friend/friends_AddFr?frId=" + frId + "&catAdd=blAdd";
        }else{
            return false;
        }
    });
    $(".frs-send-btn").click(function(){
        var resultBlFr = confirm($(".frs-name-profile").text()+"님에게 송금하시겠습니까?");
        if(resultBlFr){
            var frId = $(".frs-send-btn").attr("id")
            openTrPop(frId);
        }else{
            return false;
        }
    });
});

function clickFrName(clickFr){
    var getFrEmail = $("."+clickFr).attr("id")
    var searchDiv = $('.frs-findFr');
    checkFrSearchAjax(searchDiv, getFrEmail)
}

function checkFrSearch(){
    $(".frs-send-btn").hide();
    var searchDiv = $('.frs-findFr');
    var searchText = $("#searchFr").val();
    searchText = trim(searchText);
    if(checkEmail(searchText)){
        checkFrSearchAjax(searchDiv, searchText);
    }else if(!isNaN(searchText) && searchText.length == 12){
        checkFrSearchAjax(searchDiv, searchText);
    }else if(searchText.length == 0){
        noSearchFr(searchDiv, "noText");
    }else{
        noSearchFr(searchDiv, "other");
    }
}

function checkFrSearchAjax(searchDiv, searchText){
    $.ajax({
        url: "../friend/friends_searchFr",
        type: "POST",
        data: {text: searchText},
        success: function(forFrAjax){
            accountyFr = forFrAjax[0];
            num = forFrAjax[1];
            if(accountyFr.membery == null){
                noSearchFr(searchDiv, "other");
            }else if(num == -6){
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyFrBlock");
            }else if(num == -1){
                noSearchFr(searchDiv, "self");
            }else if(num == -2){
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyFr");
            }else if(num == -3){
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyFrReq");
            }else if(num == -4){
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyFrRec");
            }else if(num == -5){
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyBlock");
            }else{
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "newFr");
            }
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}

// 이메일 형식 체크 기능
function checkEmail(str){
    var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
    if(!reg_email.test(str)) {
        return false;
    }else{
        return true;
    }
}

function searchFr(searchDiv, name, imgPath, seq, checkFr){
    $("p.frs-name-profile").remove();
    $("p.frs-name-profile-sub").remove();
    var pTagFrName = $('<p>').text(name);
    searchDiv.append(pTagFrName);
    $(".frs-img-profile").attr("src", imgPath);
    pTagFrName.addClass("frs-name-profile");
    if(checkFr == "alreadyFr"){
        setPtag(searchDiv, "우리는 이미 친구예요!");
    }else if(checkFr == "alreadyFrReq"){
        setPtag(searchDiv, "이미 친구요청을 한 상태예요!");
    }else if(checkFr == "alreadyFrRec"){
        setPtag(searchDiv, "이미 친구요청을 받은 상태예요!");
    }else if(checkFr == "alreadyBlock"){
        setPtag(searchDiv, "차단하신 친구예요..");
    }else if(checkFr == "alreadyFrBlock"){
        setPtag(searchDiv, "친구는 맞지만.. 차단하신 친구예요..");
    }else{
        $(".frs-plus-btn").show(); $(".frs-block-btn").show();
        $(".frs-plus-btn").attr('id', seq); $(".frs-block-btn").attr("id", seq);
    }
    $(".frs-send-btn").attr('id', seq);
    $(".frs-send-btn").show();
}

function setPtag(searchDiv, msg){
    pTagFr = $("<p>").text(msg);
    pTagFr.attr("style", "color:#fd8b00");
    searchDiv.append(pTagFr);
    pTagFr.addClass("frs-name-profile-sub");
}

function noSearchFr(searchDiv, choice){
    $(".frs-plus-btn").hide(); $(".frs-block-btn").hide();
    $("p.frs-name-profile").remove();
    $("p.frs-name-profile-sub").remove();
    var pTagFr2 = $("<p>").text("Email 또는 계좌번호(숫자 12자리)를 정확하게 입력해 주세요.");
    if(choice == "noText"){
        pTagFr1 = $("<p>").text("아무것도 입력하지 않으셨습니다.");
        $(".frs-img-profile").attr("src", "/img/character/few.png");
    }else if(choice == "other"){
        pTagFr1 = $("<p>").text("찾으시는 친구가 없습니다.");
        $(".frs-img-profile").attr("src", "/img/character/sad.png");
    }else{
        pTagFr1 = $("<p>").text("자기 자신은 검색할 수 없습니다.");
        $(".frs-img-profile").attr("src", "/img/character/love.png");
        pTagFr2 = $("<p>").text("찾고싶은 친구의 Email 또는 계좌번호(숫자 12자리)를 입력해 주세요.");
    }
    pTagFr1.attr("style", "color:#fd8b00");
    searchDiv.append(pTagFr1, pTagFr2);
    pTagFr1.addClass("frs-name-profile"); pTagFr2.addClass("frs-name-profile");

}

function clickFrAdd(frName, frId, catAdd){
    var isAdd = false;
    if(catAdd == "blAdd"){
        var resultAddBl = confirm(frName+"님을 정말 차단하시겠습니까?")
        if(resultAddBl){isAdd=true;}
    }else if(catAdd == "frAdd"){
        var resultAddFr = confirm(frName+"님을 친구로 맞이하시겠습니까?")
        if(resultAddFr){isAdd=true;}
    }else{
        alert("정상 경로로 실행해 주세요!");
    }
    if(isAdd){
        location.href="/friend/friends_AddFr?frId=" + frId + "&catAdd=" + catAdd;
    }
    return false;
}

function clickFrDel(frName, frId, catDel){
    var isDel = false;
    if(catDel == "frDel"){
        var resultDelFr = confirm(frName+"님을 정말 삭제하시겠습니까?")
        if(resultDelFr){isDel=true;}
    }else if(catDel == "reqDel"){
        var resultDelReq = confirm(frName+"님에게 보낸 친구요청을 정말 취소하시겠습니까?")
        if(resultDelReq){isDel=true;}
    }else if(catDel == "recDel"){
        var resultDelRec = confirm(frName+"님에게 받은 친구요청을 정말 취소하시겠습니까?")
        if(resultDelRec){isDel=true;}
    }else if(catDel == "blDel"){
        var resultDelBl = confirm(frName+"님에 대한 차단을 취소하시겠습니까?")
        if(resultDelBl){isDel=true;}
    }else{
        alert("정상 경로로 실행해 주세요!");
    }
    if(isDel){
        location.href="/friend/friends_delFr?frId=" + frId + "&catDel=" + catDel;
    }
    return false;
}
function chatOpen(roomNumber){
    window.open('/chat/room?cr_seq='+roomNumber, '', 'width=365, height=550');
}
function openChat(f_f_mb_seq){
    var value = new Array();
    value.push(f_f_mb_seq);
    $.ajax({
        url: "/chat/insert",
        type: "GET",
        data: {f_f_mb_seq: value},
        success: function(roomNumber){
            chatOpen(roomNumber);
        },
        error: function(error){
            console.log("error: " + error);
        }
    });
}