<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/nav.css" />
<link rel="stylesheet" type="text/css" href="/css/chatRoom.css" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="/js/map.js"></script>
<script type="text/javascript" src="/js/stringBuffer.js"></script>
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
                <c:if test="${fn:length(roomInfo.memberyList) != 1}">
                    <a class="btn-open-popup" onclick="modal.classList.toggle('show');"><img class="reversal" src="/img/friend.png"></a>
                    <a onclick="action_popup.prompt('채팅방 이름을 변경합니다.', updateChatName);"><img src="/img/rename.png"></a>
                </c:if>
                <a onclick="action_popup.confirm('현재 채팅창에서 퇴장하시겠습니까?\n대화내용은 모두 사라집니다.', outChat);"><img src="/img/exit.png"></a>
            </div>
            <div class="file-list">
                <c:if test="${fn:length(files) == 0}">
                    <div class="no-file">첨부한 파일이 없습니다.</div>
                </c:if>
                <c:forEach var="file" items="${files}">
                    <a class="chat-file" href="download?cf_seq=${file.cf_seq}">
                        <div class="file-type">
                            ${fn:substring(file.cf_orgnm,fn:indexOf(file.cf_orgnm,'.')+1,fn:length(file.cf_orgnm)) }
                        </div>
                        <span class="file-name">${file.cf_orgnm}</span>
                    </a>
                </c:forEach>
            </div>
            <%-- 대화상대(누르면 대화상대랑 거래내역, 이체) --%>
            <div class="chat-member">
                <div class="member-info">
                    <input type="hidden" id="session_seq" value="${sessionScope.membery.mb_seq}" />
                    <img src="${sessionScope.membery.mb_imagepath}"/>
                    <div class="me">나</div>
                    <span class="name">${sessionScope.membery.mb_name}</span>
                </div>
                <c:forEach var="membery" items="${roomInfo.memberyList}">
                    <c:if test="${membery.mb_seq != sessionScope.membery.mb_seq}">
                         <div class="member-info">
                             <img src="${membery.mb_imagepath}"/>
                             <div class="send-button"><a onclick="openTrPop(${membery.mb_seq})">송금</a></div>

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
        <c:set var="day" value="" />
        <c:forEach var="content" items="${contents}">
            <c:if test="${content.cc_rdate_day ne day}">
                <div class="in-out-chat chatDay">${content.cc_rdate_day}</div>
                <c:set var="day" value="${content.cc_rdate_day}" />
            </c:if>
            <c:choose>
                <c:when test="${null eq content.membery.mb_seq}">
                    <div class="in-out-chat">${content.cc_content}</div>
                </c:when>
                <c:when test="${sessionScope.membery.mb_seq eq content.membery.mb_seq}">
                    <c:if test="${content.chatfile.cf_seq == null}">
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
                    <c:if test="${content.chatfile.cf_seq != null}">
                        <div class="chat ch2">
                            <div class="icon"><img src="${sessionScope.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                            <div class="chat-content">
                                <div class="chat-info">
                                    <span>${content.cc_rdate_time}<br/><span class="status-count" id="sc-${content.cc_seq}">${content.cc_status_count}</span></span>
                                </div>
                                <div class="textbox">
                                    <a class="chat-file" href="download?cf_seq=${content.chatfile.cf_seq}">
                                        <div class="file-type">
                                            ${fn:substring(content.chatfile.cf_orgnm,fn:indexOf(content.chatfile.cf_orgnm,'.')+1,fn:length(content.chatfile.cf_orgnm)) }
                                        </div>
                                        <span class="file-name">${content.chatfile.cf_orgnm}</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:when>
                <c:when test="${sessionScope.membery.mb_seq ne content.membery.mb_seq}">
                    <c:if test="${content.chatfile.cf_seq == null}">
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
                    <c:if test="${content.chatfile.cf_seq != null}">
                        <div class="chat ch1">
                            <div class="icon"><img src="${content.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                            <div class="chat-content">
                                <div class="chat-info">
                                    <div class="chat-name">
                                        <span>${content.membery.mb_name}</span>
                                    </div>
                                </div>
                                <div class="chat-text-info">
                                    <div class="textbox">
                                        <a class="chat-file" href="download?cf_seq=${content.chatfile.cf_seq}">
                                            <div class="file-type">
                                                ${fn:substring(content.chatfile.cf_orgnm,fn:indexOf(content.chatfile.cf_orgnm,'.')+1,fn:length(content.chatfile.cf_orgnm)) }
                                            </div>
                                            <span class="file-name">${content.chatfile.cf_orgnm}</span>
                                        </a>
                                    </div>
                                    <div class="chat-info">
                                        <span>${content.cc_rdate_time}<br/><span class="status-count" id="sc-${content.cc_seq}">${content.cc_status_count}</span></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:when>
            </c:choose>
        </c:forEach>
    </div>
    <div class="send-area">
        <textarea class="chat-text" required="required" id='msg'
            <c:if test="${fn:length(roomInfo.memberyList) == 1}"> readonly </c:if>></textarea>
        <div class="buttons">
            <label class="btn" for="files">
                <img src="/img/clip.png">
            </label>
            <input type="file" id="files" style="display: none;" onchange="handleFileUpload(this.files)" multiple/>
            <a class="btn" id="btnSend">
                <img src="/img/send.png">
            </a>
        </div>
    </div>
    <div class="modal-member-add">
        <form action="addChatMember" name="f">
            <input type="hidden" name="cr_seq" value="${roomInfo.cr_seq}" />
            <div class="add_body">
                <div class="make-chat-title">채팅방 초대하기</div>
                <a class="add-close">닫기!</a>
                <div class="friend-list">
                    <c:forEach var="friend" items="${friendList}">
                        <label class="member-info" for="ir-${friend.membery.mb_seq}">
                            <img src="${friend.membery.mb_imagepath}"/>
                            <span class="name">${friend.membery.mb_name}</span>
                            <input type="radio" name="f_f_mb_seq" id="ir-${friend.membery.mb_seq}" value="${friend.membery.mb_seq}">
                        </label>
                    </c:forEach>
                </div>
                <a onclick="addMember()" class="add-button">초대!</a>
            </div>
        </form>
    </div>
    <%@ include file="/WEB-INF/views/modalPopup.jsp" %>
</body>
<script>

</script>
<script src='/js/chatt.js'></script>