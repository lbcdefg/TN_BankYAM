<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/nav.css" />
<link rel="stylesheet" type="text/css" href="/css/chatRoom.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
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
                <c:forEach var="file" items="${files}">
                    <a class="chat-file">
                        <div class="file-type">
                            ${fn:substring(file.cf_orgnm,fn:indexOf(file.cf_orgnm,'.'),fn:length(file.cf_orgnm)) }
                        </div>
                        <span class="file-name">${file.cf_orgnm}</span>
                    </a>
                </c:forEach>
                <a class="chat-file">
                    <div class="file-type">
                        ${fn:substring('A.txt',fn:indexOf('A.txt','.')+1,fn:length('A.txt')) }
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
                    <input type="hidden" id="session_seq" value="${membery.mb_seq}" />
                    <img src="${sessionScope.membery.mb_imagepath}"/>
                    <div class="me">나</div>
                    <span class="name">${sessionScope.membery.mb_name}</span>
                </div>
                <c:forEach var="membery" items="${roomInfo.memberyList}">
                    <c:if test="${membery.mb_seq != sessionScope.membery.mb_seq}">
                         <div class="member-info">
                             <img src="${membery.mb_imagepath}"/>
                             <div class="send-button">송금</div>
                             <span class="name">${membery.mb_name}</span>
                         </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <span class="group-name">
            <input type="hidden" id="cr_seq" value="${roomInfo.cr_seq}" />
            <c:if test="${roomInfo.cr_name ne '' || roomInfo.cr_name ne null}">
                ${roomInfo.cr_name}
            </c:if>
            <c:if test="${roomInfo.cr_name eq '' || roomInfo.cr_name eq null}">
                <c:forEach var="membery" items="${roomInfo.memberyList}">
                    <c:if test="${membery.mb_seq != sessionScope.membery.mb_seq}">
                        ${membery.mb_name}&nbsp;
                    </c:if>
                </c:forEach>
            </c:if>
        </span>
    </div>
    <div class="wrap" id="wrap">
        <c:forEach var="content" items="${contents}">
            <c:if test="${sessionScope.membery.mb_seq eq content.membery.mb_seq}">
                <div class="chat ch2">
                    <div class="icon"><img src="${sessionScope.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                    <div class="chat-content">
                        <div class="chat-info">
                            <span>${content.cc_rdate_time}<br/><span class="status-count" id="sc-${content.cc_seq}">${content.cc_status_count}</span></span>
                        </div>
                        <div class="textbox">${content.cc_content}</div>
                    </div>
                </div>
            </c:if>
            <c:if test="${sessionScope.membery.mb_seq ne content.membery.mb_seq}">
                <div class="chat ch1">
                    <div class="icon"><img src="${content.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                    <div class="chat-content">
                        <div class="chat-name">
                            <span>${content.membery.mb_name}</span>
                        </div>
                        <div class="chat-text-info">
                            <div class="textbox">${content.cc_content}</div>
                            <div class="chat-info">
                                <span>${content.cc_rdate_time}<br/><span class="status-count" id="sc-${content.cc_seq}">${content.cc_status_count}</span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="send-area">
        <textarea class="chat-text" required="required" id='msg'></textarea>
        <input type='button' class="btn-send" value='전송' id='btnSend'>
    </div>
    <div class="modal">
        <form action="addChatMember">
            <input type="hidden" name="cr_seq" value="${roomInfo.cr_seq}" />

            <div class="modal_body">
                Modal
                <a class="modal-close">닫기</a>
                <input type="submit" value="초대"/>
                <div class="friend-list">
                    <c:forEach var="friend" items="${friendList}">
                        <label class="member-info" for="ir-${friend.membery.mb_seq}">
                            <img src="${friend.membery.mb_imagepath}"/>
                            <span class="name">${friend.membery.mb_name}</span>
                            <input type="radio" name="f_f_mb_seq" id="ir-${friend.membery.mb_seq}" value="${friend.membery.mb_seq}">
                        </label>
                    </c:forEach>
                </div>
            </div>
        </form>
    </div>
</body>
<script>
    $("#wrap").scrollTop($("#wrap")[0].scrollHeight);
    const modal = document.querySelector('.modal');
    const btnOpenPopup = document.querySelector('.btn-open-popup');
    const btnClosePopup = document.querySelector('.modal-close');

    btnOpenPopup.addEventListener('click', () => {
        modal.classList.toggle('show');
    });
    btnClosePopup.addEventListener('click', () => {
        modal.classList.toggle('show');
    });

    $(document).ready(function(){
        $("input[name=mb_email]").click(function(){
            var checkedId = $("input[name=mb_email]:checked").attr("id");
            alert(checkedId)
            $("#fr-" + checkedId).attr("style", "background-color:yellow");
        });
    });

</script>
<script src='/js/chatt.js'></script>