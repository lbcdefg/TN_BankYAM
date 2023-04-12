$(document).ready(function(){
    $('#searchFr').keypress(function(event){
        var keycode = (event.keyCode ? event.keyCode : event.which);
        if(keycode == "13"){
            checkFrSearch();
        }
    });
    $(".frs-plus-btn").click(function(){
        var resultAddFr = confirm($(".frs-name-profile").text()+"님을 친구로 추가하시겠습니까?");
        if(resultAddFr){
            var mbId = $(".frs-name-profile").attr("id")
            addFrAjax(mbId);
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
        success: function(memberyFr){
            if(memberyFr.mb_seq == null){
                noSearchFr(searchDiv, "other");
            }else if(memberyFr.mb_seq == -1){
                alert("자기자신")
                noSearchFr(searchDiv, "self");
            }else if(memberyFr.mb_seq != null && memberyFr.mb_imagepath == null){
                alert("사진만 없는 멤버")
                searchFr(searchDiv, memberyFr.mb_name, "/img/character/hi.png", memberyFr.mb_seq);
            }else{
                alert("다 있는 멤버")
                searchFr(searchDiv, memberyFr.mb_name, memberyFr.mb_imagepath, memberyFr.mb_seq);
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

function searchFr(searchDiv, name, imgPath, seq){
    $("p.frs-name-profile").remove();
    var pTagFrName = $('<p>').text(name);
    searchDiv.append(pTagFrName);
    $(".frs-img-profile").attr("src", imgPath);
    pTagFrName.addClass("frs-name-profile");
    $(".frs-plus-btn").show(); $(".frs-block-btn").show();
    $(".frs-plus-btn").attr('id', seq); $(".frs-block-btn").attr("id", seq);
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
    pTagFr1.attr("style", "color:#fd8b00")
    searchDiv.append(pTagFr1, pTagFr2);
    pTagFr1.addClass("frs-name-profile"); pTagFr2.addClass("frs-name-profile");

}

function addFrAjax(mbId){
    $.ajax({
        url: "../friend/friends_addFr",
        type: "POST",
        data: {id: mbId},
        success: function(memberyFr){
            alert(memberyFr);
        },
        error: function(error){
            alert("error: " + error);
        }
    });
}