<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>
<head>
    <title>얌</title>

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
                <div style="display:flex;">
                    <form name="f" action="edit_photo_ok" method="post" enctype="multipart/form-data">
                    <input type="file" id="upload_btn" class="upload_btn" name="file">
                    <label for="upload_btn" id="upload_btn_label" style="height:20px;">사진변경</label>
                    </form>
                    <c:if test="${membery.mb_email eq 'admin@gmail.com'}">
                        <input type="button" id="rate_btn" class="rate_btn" onclick="location.href='/admin/rate_update_ok'" value="금리/이자"></button>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <div class="profile-downcontainer">
        <div class="downcontainer-left">
            <ul class="profile-list">
                <c:if test="${membery.mb_email eq 'admin@gmail.com'}">
                <li class="list-element2 focus">
                        상품 정보
                </li>
                </c:if>
                <c:if test="${membery.mb_email ne 'admin@gmail.com'}">
                <li class="list-element1">
                        내 정보
                </li>
                <div class="list-element1-contents">
                    <a href="/member/editProfile">
                        - 프로필변경
                    </a>
                    <a href="/friend/friends?content=list">
                        - 친구관리
                    </a>
                    <a id="withdraw" style="cursor: pointer;">
                        - 회원탈퇴
                    </a>
                </div>
                </c:if>
                <c:if test="${membery.mb_email ne 'admin@gmail.com'}">
                <li class="list-element2 focus">
                        계좌 정보
                </li>
                <div class="list-element2-contents">
                    <a href="/accountM/accounts">
                        - 계좌 관리
                    </a>
                    <a href="/accountM/newAccount">
                        - 계좌 추가
                    </a>
                </div>
                </c:if>
            </ul>
            <c:if test="${membery.mb_email eq 'admin@gmail.com'}">
            <div class="jobs_search_box">
                <strong>상품추가</strong>
                <div class="jobs_search_field">
                    <form name="pdForm" action="/admin/addProduct_ok" method="post">
                        <div class="field1" style="margin-top:10px;">
                            
                            <select name="pd_type" id="pd_typeIn">
                                <option value="예금">예금</option>
                                <option value="적금">적금</option>
                            </select>
                        </div>
                        <div class="field2" style="margin-top:10px;">
                            <input id="pd_name" name="pd_name" type="text" placeholder="이름" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input id="pd_addrate" name="pd_addrate" placeholder="추가이율" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input name="pd_info" placeholder="설명" />
                        </div>
                        <button class="search-btn" type="button" id="search" >추가</button>
                    </form>
                </div>
            </div>
            </c:if>
        </div>
        <div class="downcontainer-right">
            <div class="table-div">
            <c:if test="${membery.mb_email ne 'admin@gmail.com'}">
                <div class="profile-acs-table-size350">
                    <table class="profile-acs-list-table">
                        <tr class="profile-acs-list-head">
                            <th class="profile-acs-list-5"></th>
                            <th class="profile-acs-list-18">계좌번호</th>
                            <th class="profile-acs-list-8">계좌별칭</th>
                            <th class="profile-acs-list-10">계좌상태</th>
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
                                <td class="profile-acs-list-20">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}
                                <br><span class="fontS-12 color-B39273">잔액: <fmt:formatNumber value="${ac.ac_balance}" pattern="#,###" /> 원</span></td>
                                <td class="profile-acs-list-8"><span class="acn">${ac.ac_name}</span></td>
                                <td class="profile-acs-list-10">${ac.ac_status}</td>
                                <td class="profile-acs-list-9">${ac.ac_rdate}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
                </c:if>
                <c:if test="${membery.mb_email eq 'admin@gmail.com'}">
                <div class="profile-acs-table-size350">
                    <table class="profile-acs-list-table">
                        <tr class="profile-acs-list-head">
                            <th class="profile-acs-list-5">종류</th>
                            <th class="profile-acs-list-18">상품이름</th>
                            <th class="profile-acs-list-8">상품금리</th>
                            <th class="profile-acs-list-10">상품설명</th>
                            <th class="profile-acs-list-9"></th>
                        </tr>
                        <c:forEach items="${productList}" var="pd">
                            <tr class="profile-acs-list-row">
                                <td class="profile-acs-list-5 acm">${pd.pd_type}</td>
                                <td class="profile-acs-list-20">${pd.pd_name}</td>
                                <td class="profile-acs-list-8"><span class="acn" ><fmt:formatNumber value="${pd.pd_rate+pd.pd_addrate}" pattern=".0"/></span></td>
                                <td class="profile-acs-list-10">${pd.pd_info}</td>
                                <td class="profile-acs-list-9"><a href="/admin/delete_pd_ok?pd_seq=${pd.pd_seq}" style="text-decoration:none;color:lightgray;">삭제</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <form name="selectF" action="/admin/product_option" method="get">
                    <select id="pd_type" name="pd_type" class="pd_type" style="margin-top:20px;">
                        <option value="" name=""selected>==선택==</option>
                        <option value="전체" name="">전체</option>
                        <c:forEach items="${pdSelectList}" var="pdS">
                        <option value="${pdS}" name="" >${pdS}</option>
                        </c:forEach>
                    </select>
                    </form>
                </div>
                </c:if>
                <c:if test="${membery.mb_email ne 'admin@gmail.com'}">
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
                </c:if>
            </div>
        </div>
    </div>
</body>
        <script>
            $(function(){
            var url = window.location.href;
            var urlLast = url.split('/').reverse()[0];
            stickyjobsSearch();

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
                    stickyjobsSearch();
                    windowWidth = $(window).width();
                    if(windowWidth<640){
                        $(".list-element1-contents").hide();
                        $(".list-element2-contents").hide();
                    }
                });


                $(".list-element1").on("click",function(){
                    if($(".list-element2").hasClass("focus")){
                        $(".list-element2").removeClass("focus");
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-acs-list-table").hide();
                        $(".profile-table").show();
                        $("#pd_type").hide();
                        $(".list-element2-contents").hide();
                        if(windowWidth > 641){
                            $(".list-element1-contents").show();
                        }else{
                            $(".list-element1-contents").hide();

                        }
                    }else{
                        $(".list-element1").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-acs-list-table").hide();
                        $(".profile-table").show();
                        $(".list-element2-contents").hide();
                        if(windowWidth > 641){
                            $(".list-element1-contents").show();
                        }else{
                            $(".list-element1-contents").hide();
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
                        if(windowWidth > 641){
                            $(".list-element2-contents").show();
                        }else{
                            $(".list-element2-contents").hide();
                        }
                    }else{
                        $(".list-element2").addClass("focus");
                        $(".none-table").hide();
                        $(".profile-table").hide();
                        $("#pd_type").show();
                        $(".profile-acs-list-table").show();
                        $(".list-element1-contents").hide();
                        if(windowWidth > 641){
                            $(".list-element2-contents").show();
                        }else{
                            $(".list-element2-contents").hide();
                        }
                    }
                });
              });
              function stickyjobsSearch() {
                  var windowW = $(window).width();
                  if ($('.jobs_search_box').length > 0) {
                      if (windowW > 900) {
                          $(window).scroll(function () {
                              var windowST = $(window).scrollTop();
                              var windowSclHt = windowST + $(window).height();
                              var ftTop = $('.footer-main').offset().top;
                              var pdlistTop = $('.downcontainer-right').offset().top;

                              if (windowSclHt > pdlistTop) {
                                  $('.jobs_search_box').addClass('sticky');
                              }
                              if (windowST < pdlistTop ) {
                                  $('.jobs_search_box').removeClass('sticky');
                              }
                          });
                      }
                  }
              }
        </script>
        <script>
            $("#upload_btn").on("change", function(event){
                f.submit();
            });
            $("#pd_type").on("change", function(event){
               selectF.submit();
            });
            $("#search").on("click", function(event){
                $.ajax({
                    type : "GET",
                    url : "/admin/pd_nameCheck",
                    data : {
                        "pd_name" : $("#pd_name").val(),
                        "pd_type" : $("#pd_typeIn").val(),
                    },
                    success : function(result){
                        console.log(result);
                        if(!result){
                            console.log("추가하고자 하는 상품의 이름은 : " + $("#pd_name").val());
                            pdForm.submit();
                            alert($("#pd_name").val() + " 계좌 추가가 완료되었습니다");
                        }else{
                            console.log("추가하고자 하는 상품의 이름은 : " + $("#pd_name").val());
                            alert("추가하고자 하는 상품의 이름은 " + $("#pd_name").val() + ", \n이미 있는 상품입니다");
                        }
                    }
                })
            });
            $("#pd_typeIn").on("change", function(event){
                if(event.target.value == '적금'){
                    $("#pd_addrate").attr('placeholder','추가이율(주의 기본:금리x1.5)');
                }else{
                    $("#pd_addrate").attr('placeholder','추가이율');
                }
            });
            $('#withdraw').on("click", function(event){
                $.ajax({
                    type : "GET",
                    url : "/member/checkAllBal",
                    data : {
                    },
                    success : function(result){
                        if(result == 'false'){
                            alert("계좌의 잔액을 모두 이체한 후에 회원탈퇴를 진행해주세요");
                        }else{
                            alert("정상적으로 탈퇴 처리 되었습니다");
                            window.location.href= "/member/withdraw";
                            window.location.href= "/";
                        }
                    }
                })
            });
        </script>
<%@ include file="/WEB-INF/views/footer.jsp" %>