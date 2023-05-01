<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link href="/css/transactionList.css" rel="stylesheet" type="text/css">
    <link href="/css/profile.css" rel="stylesheet" type="text/css">
    <title>뱅크얌 거래내역</title>
</head>

    <body>
        <div class="tr-frame body-main">
            <c:if test="${not empty membery}">
                <p class="tr-title fontS-35">${membery.mb_name}님의 거래내역</p>
            </c:if>
            <div class="tr-table-size350">
                <table class="tr-list-table">
                    <tr class="tr-list-head">

                        <th class="tr-list-10">계좌번호</th>
                        <th class="tr-list-10">타인 계좌번호</th>
                        <th class="tr-list-10">은행</th>
                        <th class="tr-list-10">유형</th>
                        <th class="tr-list-10">금액</th>
                        <th class="tr-list-10">잔액</th>
                        <th class="tr-list-10">메시지</th>
                        <th class="tr-list-10">날짜</th>
                    </tr>
                    <c:if test="${empty trList}">
                        <tr class="tr-list-row" style="border:none; height:400px">
                            <td class="fontS-35" align='center' colspan="6">거래내역이 없습니다</td>
                        </tr>
                    </c:if>
                    <c:forEach items="${trList}" var="tr">
                        <tr class="tr-list-row">
                            <td class="tr-list-10" name="tr.tr_ac_seq">${tr.tr_ac_seq}</td>
                            <td class="tr-list-10" name="tr.tr_other_accnum">${tr.tr_other_accnum}</td>
                            <td class="tr-list-10" name="tr.tr_other_bank">${tr.tr_other_bank}</td>
                            <td class="tr-list-10" name="tr.tr_type">${tr.tr_type}</td>
                            <td class="tr-list-10" name="tr.tr_amount">${tr.tr_amount}</td>
                            <td class="tr-list-10" name="tr.tr_after_balance">${tr.tr_after_balance}</td>
                            <td class="tr-list-10" name="tr.tr_msg">${tr.tr_msg}</td>
                            <td class="tr-list-10" name="tr.tr_date">${tr.tr_date}</td>
                        </tr>
                     </c:forEach>
                </table>
            </div>
        </div>

        <div style="float: left;">
            <div class="jobs_search_box">
                <strong>검색</strong>
                <div class="jobs_search_field">
                    <form name="f" action="/admin/addProduct_ok" method="post">
                        <div class="field1" style="margin-top:10px;">
                            <input name="tr_type" type="text" placeholder="유형" />
                        </div>
                        <div class="field2" style="margin-top:10px;">
                            <input name="tr_ac_seq" type="text" placeholder="계좌번호" />
                        </div>
                        <div class="field2" style="margin-top:10px;">
                            <input name="tr_other_accnum" type="text" placeholder="타인 계좌번호" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input name="tr_other_bank" placeholder="은행" />
                        </div>
                        <div class="field3" style="margin-top:10px;">
                            <input name="tr_date" placeholder="날짜" />
                        </div>
                        <button class="search-btn" type="button" id="search" title="검색하기">검색</button>
                    </form>
                </div>
            </div>
        </div>
    </body>




<script>
    $(document).ready(function () {
        stickyjobsSearch(); //sticky job search box
    });

    $(window).resize(function () {
        if (this.resizeTO) {
            clearTimeout(this.resizeTO);
        }
        this.resizeTO = setTimeout(function () {
            $(this).trigger('resizeEnd');
        }, 0);
    });

    $(window).on('resizeEnd', function () {
        stickyjobsSearch();
    });

    function stickyjobsSearch() {
        var windowW = $(window).width();
        if ($('.jobs_search_box').length > 0) {
            if (windowW > 900) {
                $(window).scroll(function () {
                    var windowST = $(window).scrollTop();
                    var windowSclHt = windowST + $(window).height();
                    var ftTop = $('.footer-main').offset().top + 125;
                    var jobslistTop = $('.accordion').offset().top - 300;

                    if (windowSclHt > jobslistTop) {
                        $('.jobs_search_box').addClass('sticky');
                    }
                    if (windowST < jobslistTop || windowSclHt > ftTop) {
                        $('.jobs_search_box').removeClass('sticky');
                    }
                });
            } else {
                $(window).scroll(function () {
                    $('.jobs_search_box').removeClass('sticky');
                });
            }
        }
    }
</script>

<script>
    function checkTrSearchAjax(searchDiv, searchText){
        var data = {},
        var
        $.ajax({
            url:"../trListSearch",
            type: "GET",
            data: {tr_ac_seq: tr_ac_seq, tr_type:tr_type, tr_date, tr_date, tr_amount:tr_amount},

            success: function(forTrAjax){

            },
            error: function(error){
                alert("error:"+error);
            }
        });
    }
</script>
<%@ include file="/WEB-INF/views/footer.jsp" %>