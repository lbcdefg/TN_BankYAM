$(document).ready(function(){
    $('#searchFr').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == "13"){
            checkFrSearch();
        }
    });
    $(".frs-plus-btn").click(function(){
        var resultAddFr = confirm($(".frs-name-profile").text()+"님에게 친구추가를 요청하시겠습니까?");
        if(resultAddFr){
            var frId = $(".frs-plus-btn").attr("id")
            alert(frId);
            addFrAjax(frId);
        }else{
            return false;
        }
    });
});

function checkFrSearch(){
    var searchDiv = $('.frs-findFr');
    var searchText = $("#searchFr").val();
    searchText = trim(searchText);
    alert(searchText)
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
        success: function(accountyFr){
            if(accountyFr.membery == null){
                noSearchFr(searchDiv, "other");
            }else if(accountyFr.membery.mb_seq == -1){
                alert("자기자신")
                noSearchFr(searchDiv, "self");
            }else if(accountyFr.membery.mb_seq == -2){
                alert("이미친구")
                searchFr(searchDiv, accountyFr.membery.mb_name, accountyFr.membery.mb_imagepath, accountyFr.membery.mb_seq, "alreadyFr");
            }else if(accountyFr.membery != null && accountyFr.membery.mb_imagepath == null){
                alert("사진만 없는 멤버")
                searchFr(searchDiv, accountyFr.membery.mb_name, "/img/character/hi.png", accountyFr.membery.mb_seq);
            }else{
                alert("다 있는 멤버")
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
    var pTagFrName = $('<p>').text(name);
    searchDiv.append(pTagFrName);
    $(".frs-img-profile").attr("src", imgPath);
    pTagFrName.addClass("frs-name-profile");
    if(checkFr == "alreadyFr"){
        pTagFr = $("<p>").text("우리는 이미 친구예요!");
        pTagFr.attr("style", "color:#fd8b00");
        searchDiv.append(pTagFr);
        pTagFr.addClass("frs-name-profile");
    }else{
        $(".frs-plus-btn").show(); $(".frs-block-btn").show();
        $(".frs-plus-btn").attr('id', seq); $(".frs-block-btn").attr("id", seq);
    }
}

function noSearchFr(searchDiv, choice){
    $(".frs-plus-btn").hide(); $(".frs-block-btn").hide();
    $("p.frs-name-profile").remove();
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

function addFrAjax(frId){
    $.ajax({
        url: "../friend/friends_reqFr",
        type: "POST",
        data: {frId: frId},
        success: function(check){
            if(check == "취소됨"){
                alert("이미 친구로 요청하신 상태입니다.");
            }
            alert(data);
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}