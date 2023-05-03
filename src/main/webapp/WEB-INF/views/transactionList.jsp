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
    <div class="profile-downcontainer" style="margin-bottom: 200px;">
        <div class="downcontainer-left" style="width: 30%;">

            <p class="fontS-35" style="margin-top:200px;">${membery.mb_name}님의 거래내역</p>
            <div class="jobs_search_box">
                <strong>검색</strong>
                <div class="jobs_search_field">
                        <div class="field1" style="margin-top:10px;">
                            <select id="tr_ac_seq"name="tr_ac_seq" style="width:80%; height:30px; font-size:15px;">
                            <option value="0">전체조회</option>
                                <c:forEach var="ac" items="${accList}">
                                    <option value="${ac.ac_seq}">${ac.ac_seq}[${ac.ac_name}]</option>
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
                            <input id="tr_other_bank"name="tr_other_bank" placeholder="은행" />
                        </div>
                        <button class="search-btn" type="button" id="search" onclick="checkTrSearchAjax()">검색</button>

                </div>
            </div>

        </div>

        <div class="downcontainer-right">
                <div class="table-div">
                    <div class="profile-acs-table-size350" style="margin-top:200px;">
                        <table class="profile-acs-list-table" id="trListSearch">
                            <tr class="profile-acs-list-head">
                                <th class="profile-acs-list-5" style="width:12%;">계좌명</th>
                                <th class="profile-acs-list-5">계좌 번호</th>
                                <th class="profile-acs-list-18">거래 유형</th>
                                <th class="profile-acs-list-8">이체 금액</th>
                                <th class="profile-acs-list-18">이체 후 잔액</th>
                                <th class="profile-acs-list-8">보낸분/받는분</th>
                                <th class="profile-acs-list-10">보낸/받는은행</th>
                                <th class="profile-acs-list-9" style="width:12%;">이체 날짜</th>
                            </tr>
                            <c:if test="${empty trList}">
                                <tr class="profile-acs-list-row" style="border:none; height:400px">
                                    <td class="profile-fontS-35" align='center' colspan="6">거래내역이 없습니다.</td>
                                </tr>
                            </c:if>
                            <c:forEach items="${trList}" var="tr">
                                <tr class="profile-acs-list-row">
                                    <td class="profile-acs-list-5 acm" name="${tr.accounty.ac_name}">${tr.accounty.ac_name}</td>
                                    <td class="profile-acs-list-5 acm" name="${tr.tr_ac_seq}">${tr.tr_ac_seq}</td>
                                    <td class="profile-acs-list-9" name="${tr.tr_type}">${tr.tr_type}</td>
                                    <td class="profile-acs-list-20"><span class="fontS-12 color-B39273"><fmt:formatNumber value="${tr.tr_amount}" pattern="#,###" /> 원</span></td>
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

                $('#tr_ac_seq').on('change', function(){
                    checkTrSearchAjax();
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
        if(tr_type == ""){
            tr_type = "empty";
        }

        var tr_other_accnum = document.getElementById('tr_other_accnum').value;
        if(tr_other_accnum==""){
            tr_other_accnum=0;
        }

        var tr_other_bank = document.getElementById('tr_other_bank').value;
        if(tr_other_bank == ""){
            tr_other_bank = "empty";
        }

        var param = {};
        param.tr_ac_seq = tr_ac_seq;
        param.tr_type = tr_type;
        param.tr_other_accnum = tr_other_accnum;
        param.tr_other_bank = tr_other_bank;

        $.ajax({
            url:"trListSearch",
            type:"GET",
            data: param,
            success: function(trList){
                //var dataChange = JSON.stringify(trList);
                //console.log(dataChange);
                console.log(trList);
                $("tr.profile-acs-list-row").remove();
                var tableForTrList = $(".profile-acs-list-table");
                var tbodyForTrList = tableForTrList.children("tbody");

                if(trList.length == 0){
                    var trForTrList = $("<tr>").addClass("profile-acs-list-row");
                    var tdForTrList = $("<td>").text("거래내역 없음").attr({"align":"center", "colspan":"7"});
                    tbodyForTrList.append(trForTrList);
                    trForTrList.append(tdForTrList);
                }else if(trList.length > 0){
                    for(var i=0; i<trList.length; i++){
                        var trForTrList = $("<tr>").addClass("profile-acs-list-row");
                        var tdForTrList = $("<td>").text(trList[i].accounty.ac_name).addClass("profile-acs-list-5 acm").attr("name", trList[i].accounty.ac_name); trForTrList.append(tdForTrList);
                        var tdForTrList = $("<td>").text(trList[i].tr_ac_seq).addClass("profile-acs-list-5 acm").attr("name", trList[i].tr_ac_seq); trForTrList.append(tdForTrList);
                        var tdForTrList = $("<td>").text(trList[i].tr_type).addClass("profile-acs-list-9").attr("name", trList[i].tr_type); trForTrList.append(tdForTrList);
                        var tdSpanForTrList = $("<td>").addClass("profile-acs-list-20"); trForTrList.append(tdSpanForTrList);
                        var tdSpanForTrListAmount = $("<td>").addClass("profile-acs-list-20"); trForTrList.append(tdSpanForTrListAmount);
                        var afterBal = trList[i].tr_after_balance + "";
                        var amountBal = trList[i].tr_amount + "";
                        let result = afterBal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        let result_amount = amountBal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        var spanForTrListAmount = $("<span>").text("잔액: " + result_amount + " 원").addClass("fontS-12 color-B39273"); tdSpanForTrListAmount.append(spanForTrListAmount);
                        var spanForTrList = $("<span>").text("잔액: " + result + " 원").addClass("fontS-12 color-B39273"); tdSpanForTrList.append(spanForTrList);
                        var tdForTrList = $("<td>").text(trList[i].tr_other_accnum).addClass("profile-acs-list-8").attr("name", trList[i].tr_other_accnum); trForTrList.append(tdForTrList);
                        var tdForTrList = $("<td>").text(trList[i].tr_other_bank).addClass("profile-acs-list-10").attr("name", trList[i].tr_other_bank); trForTrList.append(tdForTrList);
                        var tdForTrList = $("<td>").text(trList[i].tr_date).addClass("profile-acs-list-9").attr("name", trList[i].tr_date); trForTrList.append(tdForTrList);
                        tbodyForTrList.append(trForTrList);
                    }
                }
            },

            error: function(error){
                console.log("error:"+error);
            }

        });
    }
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>