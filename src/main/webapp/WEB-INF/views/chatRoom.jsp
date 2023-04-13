<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/nav.css" />
<link rel="stylesheet" type="text/css" href="/css/chatRoom.css" />
<script>
    function toneDown(){
        if(!document.getElementById('menuicon').checked){
            const div = document.createElement("div");
            div.classList.add("tone-down");
            document.body.appendChild(div);
        }else{
            const div = document.querySelectorAll('.tone-down')[0];
            div.remove();
        }
    }
</script>
<body>
    <div class="header">
        <input type="checkbox" id="menuicon">
        <label for="menuicon" onclick="toneDown()">
            <span></span>
            <span></span>
            <span></span>
        </label>
        <div class="sidebar">
            <%-- 파일들 --%>
            <div class="menu-list">
                <a class="btn-open-popup"><img class="reversal" src="/img/friend.png"></a>
                <a><img src="/img/rename.png"></a>
                <a><img src="/img/exit.png"></a>
            </div>
            <div class="file-list">
                <a class="chat-file">
                    <div class="file-type">
                        txt
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
                <a class="chat-file">
                    <div class="file-type">
                    </div>
                    <span class="file-name">파일1</span>
                </a>
            </div>
            <%-- 대화상대(누르면 대화상대랑 거래내역, 이체) --%>
            <div class="chat-member">
                <div class="member-info">
                    <img src="/img/character/sad.png"/>
                    <div class="me">나</div>
                    <span class="name">아무개</span>
                </div>
                <div class="member-info">
                    <img src="/img/character/sad.png"/>
                    <div class="send-button">송금</div>
                    <span class="name">아무개</span>
                </div>
            </div>
        </div>
        <span class="group-name">아무개</span>
    </div>
    <div class="wrap">
        <div class="chat ch1">
            <div class="icon"><img src="/img/yammy.png" class="fa-solid fa-user"></i></div>
            <div class="chat-content">
                <div class="chat-info">
                    <span>아무개</span><span>시간</span>
                </div>
                <div class="textbox">안녕하세요. 반갑습니다.</div>
            </div>
        </div>
        <div class="chat ch2">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="chat-content">
                <div class="chat-info">
                    <span>아무개</span><span>시간</span>
                </div>
                <div class="textbox">안녕하세요. 친절한효자손입니다. 그동안 잘 지내셨어요?</div>
            </div>
        </div>
        <div class="chat ch1">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="chat-content">
                <div class="chat-info">
                    <span>아무개</span><span>시간</span>
                </div>
                <div class="textbox">아유~ 너무요너무요! 요즘 어떻게 지내세요?</div>
            </div>
        </div>
        <div class="chat ch2">
            <div class="icon"><i class="fa-solid fa-user"></i></div>
            <div class="chat-content">
                <div class="chat-info">
                    <span>아무개</span><span>시간</span>
                </div>
                <div class="textbox">뭐~ 늘 똑같은 하루 하루를 보내는 중이에요. 코로나가 다시 극성이어서 모이지도 못하구 있군요 ㅠㅠ 얼른 좀 잠잠해졌으면 좋겠습니다요!</div>
            </div>
        </div>
    </div>
    <textarea class="chat-text" required="required"></textarea>
    <div class="modal">
        <div class="modal_body">
        Modal
        <a class="modal-close">닫기<a>
        </div>
    </div>
</body>
<script>
    const modal = document.querySelector('.modal');
    const btnOpenPopup = document.querySelector('.btn-open-popup');
    const btnClosePopup = document.querySelector('.modal-close');

    btnOpenPopup.addEventListener('click', () => {
        modal.classList.toggle('show');
    });
    btnClosePopup.addEventListener('click', () => {
        modal.classList.toggle('show');
    });
</script>