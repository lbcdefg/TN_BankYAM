<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>
<head>
    <title>얌</title>
    <script>
            $(function(){
                var windowWidth = $(window).width();
                $(window).resize(function(){
                    if(this.resizeTO){
                        clearTimeout(this.resizeTO);
                    }
                    this.resizeTO = setTimeout(function(){
                        $(this).trigger('resizeEnd');
                    });
                });

                $(window).on('resizeEnd', function(){
                    windowWidth = $(window).width();
                });

                $(".list-element1").on("click",function(){
                    if($(".list-element2").hasClass("focus")){
                        $(".list-element2").removeClass("focus");
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-acs-list-table").hide();
                        $(".profile-table").show();
                        $(".list-element2-contents").hide();
                        if(windowWidth > 659){
                            $(".list-element1-contents").show();
                        }
                    }else{
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-acs-list-table").hide();
                        $(".profile-table").show();
                        $(".list-element2-contents").hide();
                        if(windowWidth > 659){
                            $(".list-element1-contents").show();
                        }
                    }
                });

                $(".list-element2").on("click",function(){
                    if($(".list-element1").hasClass("focus")){
                        $(".list-element1").removeClass("focus");
                        $(".list-element2").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-table").hide();
                        $(".profile-acs-list-table").show();
                        $(".list-element1-contents").hide();
                        if(windowWidth > 659){
                            $(".list-element2-contents").show();
                        }
                    }else{
                        $(".list-element2").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-table").hide();
                        $(".profile-acs-list-table").show();
                        $(".list-element1-contents").hide();
                        if(windowWidth > 659){
                            $(".list-element2-contents").show();
                        }
                    }
                });
              });
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
                <div>
                    <form name="f" action="edit_photo_ok" method="post" enctype="multipart/form-data">
                    <input type="file" id="upload_btn" class="upload_btn" name="file">
                    <label for="upload_btn" id="upload_btn_label">사진변경</label>
                    </form>
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
                    <a href="/member/editProfile">
                        -프로필변경
                    </a>
                    <a href="/friend/friends?content=list">
                        -친구관리
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
                <div class="profile-acs-table-size350">
                    <table class="profile-acs-list-table">
                        <tr class="profile-acs-list-head">
                            <th class="profile-acs-list-5"></th>
                            <th class="profile-acs-list-18">계좌번호</th>
                            <th class="profile-acs-list-8">계좌별칭</th>
                            <th class="profile-acs-list-10">계좌상태</th>
                            <th class="profile-acs-list-10">잔액</th>
                            <th class="profile-acs-list-9">계좌생성일</th>
                        </tr>
                        <c:if test="${empty accountyList}">
                            <tr class="profile-acs-list-row" style="border:none; height:400px">
                                <td class="profile-fontS-35" align='center' colspan="6">계좌가 없습니다.. 불가능할텐데.. 왜죠!?</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${accountyList}" var="ac">
                            <tr class="profile-acs-list-row">
                                <td class="profile-acs-list-5 acm" id="${ac.ac_seq}" name="${ac.ac_main}">${ac.ac_main}</td>
                                <c:set var="ac_Seq" value="${ac.ac_seq}"/>
                                <%
                                    Long acSeq=(Long)pageContext.getAttribute("ac_Seq");
                                    String acSeqS = Long.toString(acSeq);
                                    pageContext.setAttribute("acSeqS", acSeqS);
                                %>
                                <c:set var="firstAcSeq" value="${fn:substring(acSeqS,0,3)}"/>
                                <c:set var="secondAcSeq" value="${fn:substring(acSeqS,3,5)}"/>
                                <c:set var="mainAcSeq" value="${fn:substring(acSeqS,5,11)}"/>
                                <c:set var="lastAcSeq" value="${fn:substring(acSeqS,11,12)}"/>
                                <td class="profile-acs-list-20">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}</td>
                                <td class="profile-acs-list-8"><span class="acn">${ac.ac_name}</span></td>
                                <td class="profile-acs-list-10">${ac.ac_status}</td>
                            <c:if test="${ac.ac_status == '사용중' or ac.ac_status == '휴면'}">
                                <td class="profile-acs-list-10"><span class="acn">${ac.ac_balance}</span></td>
                            </c:if>
                                <td class="profile-acs-list-9">${ac.ac_rdate}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
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
        <script>
            $("#upload_btn").on("change", function(event){
               f.submit();
            });
        </script>
<%@ include file="/WEB-INF/views/footer.jsp" %>