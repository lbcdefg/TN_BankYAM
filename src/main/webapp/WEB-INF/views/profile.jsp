<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>
<head>
    <title>얌</title>
    <script>
            $(function(){
                $(".list-element1").on("click",function(){
                    if($(".list-element2").hasClass("focus")){
                        $(".list-element2").removeClass("focus");
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".list-table").hide();
                        $(".profile-table").show();
                        $(".list-element2-contents").hide();
                        $(".list-element1-contents").show()
                    }else{
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".list-table").hide();
                        $(".profile-table").show();
                        $(".list-element2-contents").hide();
                        $(".list-element1-contents").show()
                    }
                })
              })
              $(function(){
                $(".list-element2").on("click",function(){
                    if($(".list-element1").hasClass("focus")){
                        $(".list-element1").removeClass("focus");
                        $(".list-element2").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-table").hide();
                        $(".list-table").show();
                        $(".list-element1-contents").hide();
                        $(".list-element2-contents").show();
                    }else{
                        $(".list-element2").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-table").hide();
                        $(".list-table").show();
                        $(".list-element1-contents").hide();
                        $(".list-element2-contents").show();
                    }
                })
              })
        </script>
</head>
<body>
    <div class="profile-upcontainer">
        <div class="profile-div">
            <div class="profile-photo">
                <img src="${membery.mb_imagepath}" style="width:100%;height:100%;object-fit:cover;">
            </div>
            <div>
                <div class="profile-name">
                    <h2 style="margin:0;font-size:30px;">${membery.mb_name}</h2> &nbsp;
                    <p style="margin-top:15px;color:lightgray;">(${membery.mb_email})</p>
                </div>
                <div class="profile-friends">
                    <h3 style="margin: 0;">친구: 145명</h3>
                </div>
            </div>
        </div>
    </div>
    <div class="profile-downcontainer">
        <div class="downcontainer-left">
            <ul class="profile-list">
                <li class="list-element1">
                        내 정보
                </li>
                <div class="list-element1-contents">
                    <a href="#">
                        -프로필변경
                    </a>
                </div>
                <li class="list-element2">
                        계좌 정보
                </li>
                <div class="list-element2-contents">
                    <a href="#">
                        -계좌 관리
                    </a>
                    <a href="#">
                        -계좌 추가
                    </a>
                </div>
            </ul>
        </div>
        <div class="downcontainer-right">
            <div class="table-div">
                <table class="list-table" cellpadding='7' cellspacing='2'>
                    <thead>
                        <tr>
                            <th>종류</th>
                            <th>별칭</th>
                            <th>계좌번호</th>
                            <th>잔액</th>
                            <th>개설일자</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${accountyList}" var="account">
                        <tr>
                        <td>
                            예금통장
                        </td>
                        <td>
                            ${account.ac_name}
                        </td>
                        <td>
                            ${account.ac_seq}
                        </td>
                        <td>
                            ${account.ac_balance}원
                        </td>
                        <td>
                            ${account.ac_rdate}
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <table class="profile-table" cellpadding='7' cellspacing='2'>
                    <tr>
                        <th>이름</th>
                        <td>${membery.mb_name}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${membery.mb_email}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>${membery.mb_addr}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${membery.mb_phone}</td>
                    </tr>
                    <tr>
                        <th>직업</th>
                        <td>${membery.mb_job}</td>
                    </tr>
                    <tr>
                        <th>연봉</th>
                        <td>${membery.mb_salary} 만원</td>
                    </tr>
                </table>
                <table class="none-table">
                    <tr>
                        <th>목록을 선택해주세요</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>