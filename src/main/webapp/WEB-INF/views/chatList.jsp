<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/chatList.css" />
<link rel="stylesheet" type="text/css" href="/css/chatRoom.css" />
<script>
	function listPlus(){
		const item = document.createElement("li");
		item.classList.add("album-table-content")
		item.innerHTML = `<span class="alarmCount">3</span>
		<a onClick="window.open(this.href, '', 'width=400, height=500'); return false;" class="album-table-img">
		<img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
		<dl>
			<dt>
				<a onClick="window.open(this.href, '', 'width=400, height=500'); return false;" class="album-table-sub" title="채팅방이름">
				채팅방 이름</a>
			</dt>
			<dd>마지막 대화</dd>
			<dd>마지막 대화 시간</dd>
		</dl>`;
		document.querySelector(".album-table-list").append(item);
	}
</script>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="body-main">
    <div class="chat-buttons">
        <ul class="button-list">
            <li><a href="/board/list.do">마지막 대화 시간</a></li>
            <li><a href="/board/list.do">채팅방 이름</a></li>
            <li class="active btn-open-chat"><a>채팅방 만들기</a></li>
            <li class="active btn-open-group"><a>그룹 채팅방 만들기</a></li>
        </ul>
    </div>
    <div class="album-table">
        <ul class="album-table-list">
            <c:forEach var="chatroom" items="${chatroomList}">
                <li class="album-table-content">
                    <span class="alarmCount">${chatroom.status_count}</span>
                    <a onClick="window.open('room?cr_seq='+${chatroom.cr_seq}, '', 'width=400, height=500'); return false;" class="album-table-img">
                    <c:if test="${fn:length(chatroom.memberyList) == 2}">
                        <c:forEach var="membery" items="${chatroom.memberyList}">
                            <c:if test="${membery.mb_seq != sessionScope.membery.mb_seq}">
                                <img style="vertical-align:top; border:none" src="${membery.mb_imagepath}"></a>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${fn:length(chatroom.memberyList) != 2}">
                        <img style="vertical-align:top; border:none" src="/img/character/few.png"></a>
                    </c:if>
                    <dl>
                        <dt>
                            <a onClick="window.open('room?cr_seq='+${chatroom.cr_seq}, '', 'width=400, height=500'); return false;" class="album-table-sub" title="채팅방이름">
                                <c:if test="${chatroom.cr_name != null}">
                                    ${chatroom.cr_name}
                                </c:if>
                                <c:if test="${chatroom.cr_name == null}">
                                    <c:forEach var="membery" items="${chatroom.memberyList}">
                                        <c:if test="${membery.mb_seq != sessionScope.membery.mb_seq}">
                                            ${membery.mb_name}
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                            </a>
                        </dt>
                        <dd>${chatroom.chatcontent.cc_content}</dd>
                        <dd>${chatroom.chatcontent.cc_rdate}</dd>
                    </dl>
                </li>
            </c:forEach>
            <li class="album-table-content">
                <span class="alarmCount">3</span>
                <a onClick="window.open('room', '', 'width=400, height=500'); return false;" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a onClick="window.open('room', '', 'width=400, height=500'); return false;" class="album-table-sub" title="채팅방이름">
                        채팅방 이름</a>
                    </dt>
                    <dd>마지막 대화</dd>
                    <dd>마지막 대화 시간</dd>
                </dl>
            </li>
        </ul>
    </div>
    <div onclick="listPlus()" class="listPlus"><div class="listPlus-text">더 보기 +</div></div>
    <div class="make-chat">
        <form action="insert">
            <div class="make-chat-body">
                일대일 채팅방 만들기
                <a class="chat-close">닫기</a>
                <button>만들기</button>
                <div class="friend-list">
                    <c:forEach var="friend" items="${frList}">
                        <label class="member-info" for="r-${friend.membery.mb_seq}" id="fr-1">
                            <img src="${friend.membery.mb_imagepath}"/>
                            <span class="name">${friend.membery.mb_name}</span>
                            <input type="radio" name="f_mb_seq" value="${friend.membery.mb_seq}" id="r-${friend.membery.mb_seq}">
                        </label>
                    </c:forEach>
                    <label class="member-info" for="r-1" id="fr-1">
                        <img src="/img/character/sad.png"/>
                        <span class="name">아무개</span>
                        <input type="radio" name="mb_email" id="r-1">
                    </label>
                </div>
            </div>
        </form>
    </div>

    <div class="make-group">
        <form action="insert">
        <div class="make-group-body">
        그룹 채팅방 만들기
        <a class="group-close">닫기</a>
        <button>만들기</button>
            <div class="friend-list">
                <c:forEach var="friend" items="${frList}">
                    <label class="member-info" for="c-${friend.membery.mb_seq}" id="fr-1">
                        <img src="${friend.membery.mb_imagepath}"/>
                        <span class="name">${friend.membery.mb_name}</span>
                        <input type="checkbox" name="f_mb_seq" value="${friend.membery.mb_seq}" id="c-${friend.membery.mb_seq}">
                    </label>
                </c:forEach>
                <label class="member-info" for="c-1" id="fr-1">
                    <img src="/img/character/sad.png"/>
                    <span class="name">아무개</span>
                    <input type="checkbox" name="mb_email" id="c-1">
                </label>
            </div>
        </div>
        </form>
    </div>
</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
<script>
    const chatModal = document.querySelector('.make-chat');
    const btnOpenChat = document.querySelector('.btn-open-chat');
    const btnCloseChat = document.querySelector('.chat-close');

    btnOpenChat.addEventListener('click', () => {
        chatModal.classList.toggle('show');
    });
    btnCloseChat.addEventListener('click', () => {
        chatModal.classList.toggle('show');
    });

    const groupModal = document.querySelector('.make-group');
    const btnOpenGroup = document.querySelector('.btn-open-group');
    const btnCloseGroup = document.querySelector('.group-close');

    btnOpenGroup.addEventListener('click', () => {
        groupModal.classList.toggle('show');
    });
    btnCloseGroup.addEventListener('click', () => {
        groupModal.classList.toggle('show');
    });

</script>