<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<head>
    <title>Tropical Night</title>
</head>
<!-- Contents -->
<%@ include file="/WEB-INF/views/nav.jsp" %>
<body style="margin:0">
    <div class="introduce-wrap">
        <div class="introduce-image">
            <div>
                <strong class="introduce-text1">BANKYAM<br></strong>
                <br>
                <strong class="introduce-text2">
                    한 사람, 한 사람을 위해 시작한 은행이<br>
                    더 많은 사람들이 찾는 모두의 은행이 되었습니다<br>
                    <br><br>
                    보내고, 받고, 모으고, 쓰는<br>
                    당신의 모든 일이 바뀌고 있습니다.<br>
                    <br><br><br><br><br>
                    모두의 은행, BANKYAM<br>
                </strong>
            </div>
        </div>
        <div class="introduce-history">
            <br><br><br>
            <h1>TN COMPANY 연혁</h1><br>
            <div>
                <h2>2022.12 파일 애플 런칭</h2>
                <ol class="introduce-history">
                    <li><img src="img/fileapple.png"></li><hr>
                </ol>
                <h2>2023.01 파파야 마켓 런칭</h2>
                <ol class="introduce-history">
                    <li><img src="img/papaya.png"></li><hr>
                </ol>
                <h2>2023.02 리치 루트 런칭</h2>
                <ol class="introduce-history">
                    <li><img src="img/litchi_root.png"></li><hr>
                </ol>
                <h2>2023.03 집팜 런칭</h2>
                <ol class="introduce-history">
                    <li><img src="img/ZIP PALM.png" style="height:160px;"></li><hr>
                </ol>
                <h2>2023.05 뱅크얌 런칭</h2>
                <ol class="introduce-history">
                    <li><img src="img/YamLogoHover.png" style="height:160px;"></li><hr>
                </ol>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>
</html>