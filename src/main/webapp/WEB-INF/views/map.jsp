<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌 - 찾아오는길</title>
</head>
<!-- Contents -->
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body style="margin:0">
    <center>
        <div class="map-main">
            <p class="map-title">오시는 길</p>
            <div class="map-col-lt">
                <div class="map-size">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2662.4645066027115!2d126.8782773987905!3d37.47909353953361!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b61e3354204f9%3A0x12b02f6401815f80!2z7ZWc6rWt7IaM7ZSE7Yq47Juo7Ja07J247J6s6rCc67Cc7JuQ!5e0!3m2!1sko!2skr!4v1677726916879!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
            <div class="map-col-rt">
                <ul class="map-list">
                    <li><img src="/img/map.png"><p>서울특별시 금천구 가산동 월드메르디앙벤처센터2차 4층</p></li>
                    <li><img src="/img/metro.png"><p>가산디지털단지역 1호선, 7호선 5번출구 도보 5분</p></li>
                    <li><img src="/img/phone.png"><p>02 - 1234 - 1234</p></li>
                </ul>
            </div>
        </div>
    </center>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>