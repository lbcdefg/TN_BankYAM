<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/friends.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="/js/trim.js"></script>
    <title>BankYam Friends</title>
</head>

<body>
    <div class="frs-frame body-main">
        <div class="frs-lt">
            <div class="frs-search">
                <input type="text" class="frs-search-input" id="searchFr" placeholder="이메일 또는 계좌번호" size="20"/>
                <button type="button" class="frs-search-btn" onclick="checkFrSearch()">검색</button>
            </div>
            <div class="frs-findFr">
                <img class="frs-img-profile" src="/img/character/love.png"/>
                <p class="frs-name-profile">찾으시는 친구의 Email 또는 계좌번호(숫자 12자리)를 입력해 주세요.</p>
            </div>
            <div class="frs-manage">
                <button type="button" class="frs-plus-btn">친구추가</button>
                <button type="button" class="frs-block-btn">차단</button>
            </div>
            <div class="frs-send">
                <button type="button" class="frs-send-btn">송금하기</button>
            </div>
        </div>

        <!-- 모델에 따라 친구목록, 받은/요청목록, 차단목록 -->
        <div class="frs-rt">
            <div class="frs-list-group">
                <c:choose>
                    <c:when test="${content == 'list'}">
                        <a class="frs-group-li-a" style="z-index:3; color:#fd8b00; font-weight:bold" href="/friend/friends?content=list">친구목록</a>
                        <a class="frs-group-rq-a" style="z-index:1" href="/friend/friends?content=req">받은/요청 친구</a>
                        <a class="frs-group-bk-a" style="z-index:1" href="/friend/friends?content=block">차단목록</a>
                    </c:when>
                    <c:when test="${content == 'req'}">
                        <a class="frs-group-li-a" style="z-index:1" href="/friend/friends?content=list">친구목록</a>
                        <a class="frs-group-rq-a" style="z-index:3; color:#fd8b00; font-weight:bold" href="/friend/friends?content=req">받은/요청 친구</a>
                        <a class="frs-group-bk-a" style="z-index:1" href="/friend/friends?content=block">차단목록</a>
                    </c:when>
                    <c:when test="${content == 'block'}">
                        <a class="frs-group-li-a" style="z-index:1" href="/friend/friends?content=list">친구목록</a>
                        <a class="frs-group-rq-a" style="z-index:1" href="/friend/friends?content=req">받은/요청 친구</a>
                        <a class="frs-group-bk-a" style="z-index:3; color:#fd8b00; font-weight:bold" href="/friend/friends?content=block">차단목록</a>
                    </c:when>
                </c:choose>
            </div>

            <!-- 친구 리스트 -->
            <c:if test="${content == 'list'}">
                <div class="frs-list">
                    <table class="frs-list-table">
                    <c:if test="${empty frList}">
                        <tr class="frs-list-row" style="border:none; height:400px">
                            <td class="fontS-25" align='center' colspan="5">친구가 없습니다.. 친구를 추가해 보세요!</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${frList}" var="fl">
                        <tr class="frs-list-row">
                            <td class="frs-list-15"><img class="frs-img-circle" src="${fl.membery.mb_imagepath}" height="45px"/></td>
                            <td class="frs-list-34 frs-click" onclick="clickFrName('frs-${fl.membery.mb_seq}')">
                                <fmt:formatDate var="frsDate" value="${fl.f_rdate}" pattern="yyyy-MM-dd" />
                                <c:if test="${nowTime == frsDate}">
                                    <span class="fontS-10 color-fb8b00">new</span>&nbsp;
                                </c:if>
                                ${fl.membery.mb_name}</td>
                            <input type="hidden" class="frs-${fl.membery.mb_seq}" id="${fl.membery.mb_email}"/>
                            <td class="frs-list-12"><a class="frs-click" onclick="openTrPop(${fl.membery.mb_seq})">송금</a></td>
                            <td class="frs-list-12"><a class="frs-click" onclick="openChat(${fl.membery.mb_seq})">대화</a></td>
                            <td class="frs-list-12"><a class="frs-click" onclick="clickFrDel('${fl.membery.mb_name}', ${fl.membery.mb_seq}, 'frDel')">삭제</a></td>
                            <c:set var="loop_flag" value="false" />
                            <c:forEach items="${frBlocklist}" var="bl">
                                <c:if test="${bl.membery.mb_seq == fl.membery.mb_seq}">
                                    <td class="frs-list-15" style="color:#fd8b00">차단상태</td>
                                    <c:set var="loop_flag" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:if test="${not loop_flag}">
                                <td class="frs-list-15"><a class="frs-click" onclick="clickFrAdd('${fl.membery.mb_name}', ${fl.membery.mb_seq}, 'blAdd')">차단</a></td>
                            </c:if>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
            </c:if>


            <!-- 받은/요청 친구 리스트 -->
            <c:if test="${content == 'req'}">
                <div class="frs-req">
                    <table class="frs-req-table">
                    <c:if test="${empty frReqList}">
                        <tr class="frs-req-row" style="border:none; height:250px">
                            <td class="fontS-25" align='center' colspan="5">요청하신 [친구]가 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${frReqList}" var="req">
                        <tr class="frs-req-row">
                            <td class="frs-list-15"><img class="frs-img-circle" src="${req.membery.mb_imagepath}" height="45px"/></td>
                            <td class="frs-list-34 frs-click" onclick="clickFrName('frs-${req.membery.mb_seq}')">${req.membery.mb_name}</td>
                            <input type="hidden" class="frs-${req.membery.mb_seq}" id="${req.membery.mb_email}"/>
                            <td class="frs-list-27 color-fb8b00">친구요청 한 상태</td>
                            <td class="frs-list-15"><a class="frs-click" onclick="clickFrAdd('${req.membery.mb_name}', ${req.membery.mb_seq}, 'blAdd')">차단</a></td>
                            <td class="frs-list-12"><a class="frs-click" onclick="clickFrDel('${req.membery.mb_name}', ${req.membery.mb_seq}, 'reqDel')">취소</a></td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
                <div class="frs-rec">
                    <table class="frs-rec-table">
                    <c:if test="${empty frRecList}">
                        <tr class="frs-rec-row" style="border:none; height:250px">
                            <td class="fontS-25" align='center' colspan="5">요청받은 [친구]가 없습니다.</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${frRecList}" var="rec">
                        <tr class="frs-rec-row">
                            <td class="frs-list-15"><img class="frs-img-circle" src="${rec.membery.mb_imagepath}" height="45px"/></td>
                            <td class="frs-list-34 frs-click" onclick="clickFrName('frs-${rec.membery.mb_seq}')">${rec.membery.mb_name}</td>
                            <input type="hidden" class="frs-${rec.membery.mb_seq}" id="${rec.membery.mb_email}"/>
                            <td class="frs-list-27 color-fb8b00">친구요청 받은상태</td>
                            <td class="frs-list-12"><a class="frs-click" onclick="clickFrAdd('${rec.membery.mb_name}', ${rec.membery.mb_seq}, 'frAdd')">수락</a></td>
                            <td class="frs-list-12"><a class="frs-click" onclick="clickFrDel('${rec.membery.mb_name}', ${rec.membery.mb_seq}, 'recDel')">취소</a></td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
            </c:if>

            <!-- 받은/요청 친구 리스트 -->
            <c:if test="${content == 'block'}">
                <div class="frs-list">
                    <table class="frs-list-table">
                    <c:if test="${empty frBlocklist}">
                        <tr class="frs-list-row" style="border:none; height:400px">
                            <td class="fontS-25" align='center' colspan="5">차단하신 친구가 없어요!</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${frBlocklist}" var="bl">
                        <tr class="frs-list-row">
                            <td class="frs-list-15"><img class="frs-img-circle" src="${bl.membery.mb_imagepath}" height="45px"/></td>
                            <td class="frs-list-34 frs-click" onclick="clickFrName('frs-${bl.membery.mb_seq}')">${bl.membery.mb_name}</td>
                            <input type="hidden" class="frs-${bl.membery.mb_seq}" id="${bl.membery.mb_email}"/>
                            <td class="frs-list-27 color-fb8b00">차단된 상태</td>
                            <td class="frs-list-24"><a class="frs-click" onclick="clickFrDel('${bl.membery.mb_name}', ${bl.membery.mb_seq}, 'blDel')">차단취소</a></td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</body>

<script src="/js/friends.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>