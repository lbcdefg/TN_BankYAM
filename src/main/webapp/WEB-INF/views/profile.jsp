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
                }else{
                    $(".list-element1").addClass("focus");
                    $(".none-table").hide();
                    $(".list-table").hide();
                    $(".profile-table").show();
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
                }else{
                    $(".list-element2").addClass("focus");
                    $(".none-table").hide();
                    $(".profile-table").hide();
                    $(".list-table").show();
                }
            })
          })
    </script>
</head>
<body>
    <div class="profile-upcontainer">
        <div style="width:50%;height:100%;display:flex">
            <div class="profile-photo">
                <img src="/img/yammy.png" style="width:100%;height:100%;object-fit:cover;">
            </div>
            <div>
                <div class="profile-name">
                    <h2 style="margin:0;font-size:30px;">박종서</h2> &nbsp;
                    <p style="margin-top:15px;color:lightgray;">(whdtj6292@naver.com)</p>
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
                <li class="list-element2">
                        계좌 정보
                </li>
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
                        <tr>
                        <td>
                            예금통장
                        </td>
                        <td>
                            예삐
                        </td>
                        <td>
                            937702-00-188684
                        </td>
                        <td>
                            200,580원
                        </td>
                        <td>
                            2020.06.15
                        </td>
                        </tr>
                        <tr>
                            <td>
                                예금통장
                            </td>
                            <td>
                                예삐
                            </td>
                            <td>
                                937702-00-188684
                            </td>
                            <td>
                                200,580원
                            </td>
                            <td>
                                2020.06.15
                            </td>
                        </tr>
                        <tr>
                            <td>
                                예금통장
                            </td>
                            <td>
                                예삐
                            </td>
                            <td>
                                937702-00-188684
                            </td>
                            <td>
                                200,580원
                            </td>
                            <td>
                                2020.06.15
                            </td>
                        </tr>
                        <tr>
                            <td>
                                예금통장
                            </td>
                            <td>
                                예삐
                            </td>
                            <td>
                                937702-00-188684
                            </td>
                            <td>
                                200,580원
                            </td>
                            <td>
                                2020.06.15
                            </td>
                        </tr>
                        <tr>
                            <td>
                                예금통장
                            </td>
                            <td>
                                예삐
                            </td>
                            <td>
                                937702-00-188684
                            </td>
                            <td>
                                200,580원
                            </td>
                            <td>
                                2020.06.15
                            </td>
                        </tr>
                        <tr>
                            <td>
                                예금통장
                            </td>
                            <td>
                                예삐
                            </td>
                            <td>
                                937702-00-188684
                            </td>
                            <td>
                                200,580원
                            </td>
                            <td>
                                2020.06.15
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table class="profile-table" cellpadding='7' cellspacing='2'>
                    <tr>
                        <th>이름</th>
                        <td>박종서</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>whdtj6292@naver.com</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>서울특별시 강동구 풍성로 45길18, 603호</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>01030296292</td>
                    </tr>
                    <tr>
                        <th>직업</th>
                        <td>풀스택 개발자</td>
                    </tr>
                    <tr>
                        <th>연봉</th>
                        <td>1억2천</td>
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