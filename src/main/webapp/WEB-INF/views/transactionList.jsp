<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <title>얌</title>
    <link href="/css/transfer.css" rel="stylesheet" type="text/css">
    <link href="/css/profile.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="profile-downcontainer">
        <div class="downcontainer-left">

            <p class="fontS-35" style="margin-top:200px;">${membery.mb_name}님의 거래내역</p>
            <div class="jobs_search_box">
                <strong>검색</strong>
                <div class="jobs_search_field">

                        <div class="field1" style="margin-top:10px;">

                            <select id="tr_ac_seq"name="tr_ac_seq"  >
                                <c:forEach var="tr" items="${trList}">
                                    <option value="${tr.tr_ac_seq}">${tr.tr_ac_seq}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="field2" style="margin-top:10px;">
                            <input id="tr_type" name="tr_type" type="text" placeholder="입금/송금" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input id="tr_other_accnum" name="tr_other_accnum" placeholder="타인 계좌" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input id="tr_date"name="tr_date" placeholder="날짜" />
                        </div>

                        <button class="search-btn" type="button" id="search" onclick="checkTrSearchAjax()">검색</button>

                </div>
            </div>

        </div>
        <div class="downcontainer-right">
            <div class="table-div">

                <div class="profile-acs-table-size350" style="margin-top:200px;">
                    <table class="profile-acs-list-table">
                        <tr class="profile-acs-list-head">
                            <th class="profile-acs-list-5">계좌번호</th>
                            <th class="profile-acs-list-18">유형</th>
                            <th class="profile-acs-list-18">이체 후 잔액</th>
                            <th class="profile-acs-list-8">타인계좌번호</th>
                            <th class="profile-acs-list-10">보낸 은행</th>
                            <th class="profile-acs-list-9">보낸 날짜</th>
                        </tr>
                        <c:if test="${empty trList}">
                            <tr class="profile-acs-list-row" style="border:none; height:400px">
                                <td class="profile-fontS-35" align='center' colspan="6">거래내역이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach items="${trList}" var="tr">
                            <tr class="profile-acs-list-row">
                                <td class="profile-acs-list-5 acm" id="search"></td>
                                <td class="profile-acs-list-5 acm" id="${tr.tr_ac_seq}" name="${tr.tr_ac_seq}">${tr.tr_ac_seq}</td>
                                <c:set var="tr_ac_seq" value="${tr.tr_ac_seq}"/>
                                <td class="profile-acs-list-9" name="${tr.tr_type}">${tr.tr_type}</td>
                                <td class="profile-acs-list-20"><span class="fontS-12 color-B39273">잔액: <fmt:formatNumber value="${tr.tr_after_balance}" pattern="#,###" /> 원</span></td>
                                <td class="profile-acs-list-8" name="${tr.tr_other_accnum}"><span class="acn">${tr.tr_other_accnum}</span></td>
                                <td class="profile-acs-list-10" name="${tr.tr_other_bank}">${tr.tr_other_bank}</td>
                                <td class="profile-acs-list-9" name="${tr.tr_date}">${tr.tr_date}</td>

                            </tr>
                        </c:forEach>
                    </table>
                </div>
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
                        $("#tr_type").hide();
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
                        $("#tr_type").show();
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
                              var trlistTop = $('.downcontainer-right').offset().top;

                              if (windowSclHt > trlistTop) {
                                  $('.jobs_search_box').addClass('sticky');
                              }
                              if (windowST < trlistTop ) {
                                  $('.jobs_search_box').removeClass('sticky');
                              }
                          });
                      }
                  }
              }
        </script>

        <script>
            function checkTrSearchAjax(){
                var tr_ac_seq = document.getElementById('tr_ac_seq').value;
                var tr_type = document.getElementById('tr_type').value;
                var tr_other_accnum = document.getElementById('tr_other_accnum').value;
                var tr_date = document.getElementById('tr_date').value;

                $.ajax({
                    url:"trListSearch",
                    type:"GET",
                    data:{tr_ac_seq:tr_ac_seq, tr_date:tr_date, tr_type:tr_type, tr_other_accnum:tr_other_accnum},
                    success: function(data){
                        var dataChange = JSON.stringify(data);
                        console.log(dataChange);
                        console.log(data);
                        $("#search").text(data.tr_type);
                        $("#search").text(data.tr_ac_seq);
                        $("#search").text(data.tr_other_accnum);
                        $("#search").text(data.tr_date);
                    },

                    error: function(error){
                        console.log("error:"+error);
                    }

                });
            }
        </script>
<%@ include file="/WEB-INF/views/footer.jsp" %>