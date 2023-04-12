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
                <input type="text" class="frs-search-input" id="searchFr" size="20"/>
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
        </div>

        <!-- 모델에 따라 친구목록, 받은/요청목록, 차단목록 -->
        <div class="frs-rt">
            <div class="frs-list-group">
                <c:choose>
                    <c:when test="${not empty frList}">
                        <a class="frs-group-li-a" style="z-index:2" href="/friend/friends?content=list">친구목록</a>
                        <a class="frs-group-rq-a" href="/friend/friends?content=req">받은/요청 친구</a>
                        <a class="frs-group-bk-a" href="/friend/friends?content=block">차단목록</a>
                    </c:when>
                    <c:when test="${not empty frReqList && not empty frRecList}">
                        <a class="frs-group-li-a" href="/friend/friends?content=list">친구목록</a>
                        <a class="frs-group-rq-a" style="z-index:2" href="/friend/friends?content=req">받은/요청 친구</a>
                        <a class="frs-group-bk-a" href="/friend/friends?content=block">차단목록</a>
                    </c:when>
                </c:choose>
            </div>

            <!-- 친구 리스트 -->
            <div class="frs-list">
                <table class="frs-list-table">
                    <tr class="frs-list-row">
                        <th class="frs-list-30">프로필사진</th>
                        <th class="frs-list-30">이름</th>
                        <th class="frs-list-10"><a href="#">송금</a></th>
                        <th class="frs-list-10"><a href="#">대화</a></th>
                        <th class="frs-list-10"><a href="#">삭제</a></th>
                        <th class="frs-list-10"><a href="#">차단</a></th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>

<script src="/js/friends.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>