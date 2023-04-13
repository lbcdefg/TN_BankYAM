<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
    <title>지금은 뱅크얌</title>
</head>
<%@ include file="/WEB-INF/views/nav.jsp" %>
    <body><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <div>
            <button onclick="window.open('transfer', '_blank', 'width=800 height=600')"> 계좌이체 </button>

        </div>
    </body>
<%@ include file="/WEB-INF/views/footer.jsp" %>