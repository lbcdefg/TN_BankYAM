<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/newAccount.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam New Account</title>
</head>

<body>
    <div class="nac-frame body-main">
        <div class="nac-frame-header">
            <h1 class="nac-header-title">신규 계좌 개설</h1>
        </div>
        <div class="nac-main">
            <div class="nac-btn-row">
                <div class="nac-btn-headerGroup">
                    <button type="button" class="nac-deposit focus" value="deposit" onclick="getValue(this)">예금상품</button>
                    <button type="button" class="nac-saving" value="saving" onclick="getValue(this)">적금상품</button>
                </div>
            </div>
            <form name="nacf" class="nac-form" method="post" action="accounts_newAc" novalidate>
                <div class="nac-row margin-bottom-30">
                    <div class="row-in-select">
                        <label>상품 선택</label>
                        <select id="pd_named" name="ac_pd_seq_dummy" class="form-control margin-bottom-20">
                            <c:forEach items="${pdNames}" var="pd">
                                <c:set var="rate" value="${pd.pd_rate}"/>
                                <c:set var="addRate" value="${pd.pd_addrate}"/>
                                <%
                                    Float rate = (Float)pageContext.getAttribute("rate");
                                    Float addRate = (Float)pageContext.getAttribute("addRate");
                                    Float sumF = rate + addRate;
                                    String sum = String.format("%.2f",sumF);
                                    pageContext.setAttribute("sum", sum);
                                %>
                                <option class="pd-option" id="${pd.pd_seq}" value="${pd.pd_name}">${pd.pd_name} (이자율: ${sum} / 적용일: ${pd.pd_rdate})</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="nac-row-block">
                    <label>계좌별칭</label><br>
                    <input type="text" class="form-control margin-bottom-20" id="ac_name" name="ac_name" maxlength="15" spellcheck="false" autocomplete='off' />
                    <div class="nac-psC-pTag0"></div>
                </div>
                <div class="nac-row">
                    <div class="nac-row-half">
                        <label>계좌비밀번호</label>
                        <input type="password" pattern="[0-9]*" class="form-control margin-bottom-20" id="ac_pwd" name="ac_pwd" maxlength="4" spellcheck="false" autocomplete="off" />
                        <div class="nac-psC-pTag1"></div>
                    </div>
                    <div class="nac-row-half">
                        <label>계좌비밀번호(확인)</label>
                        <input type="password" pattern="[0-9]*" class="form-control margin-bottom-20" id="ac_pwd2" name="ac_pwd2" maxlength="4" spellcheck="false" autocomplete="off" />
                        <div class="nac-psC-pTag2"></div>
                    </div>
                </div>

                <div class="nac-row margin-bottom-30">
                    <div class="row-in-select">
                        <label>희망이자지급일</label>
                        <select id="ac_udated" name="ac_udate_dummy" class="form-control margin-bottom-20">
                            <c:forEach items="${day}" var="d">
                                <c:choose>
                                    <c:when test="${monthYear.nM == 1}">
                                        <c:choose>
                                            <c:when test="${d <= nowDay}">
                                                <option class="add1" value="${monthYear.nY}-${monthYear.nNM}-${d}">매달 ${d}일 (${monthYear.nY}. ${monthYear.nNM}. ${d} 부터)</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option class="add1" value="${monthYear.nY}-${monthYear.nM}-${d}">매달 ${d}일 (${monthYear.nY}. ${monthYear.nM}. ${d} 부터)</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${monthYear.nNM == 1}">
                                        <c:choose>
                                            <c:when test="${d <= nowDay}">
                                                <option class="add1" value="${monthYear.nY}-${monthYear.nNM}-${d}">매달 ${d}일 (${monthYear.nY}. ${monthYear.nNM}. ${d} 부터)</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option class="add1" value="${monthYear.rY}-${monthYear.nM}-${d}">매달 ${d}일 (${monthYear.nM}. ${d} 부터)</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${d <= nowDay}">
                                                <option class="add1" value="${monthYear.rY}-${monthYear.nNM}-${d}">매달 ${d}일 (${monthYear.nNM}. ${d} 부터)</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option class="add1" value="${monthYear.rY}-${monthYear.nM}-${d}">매달 ${d}일 (${monthYear.nM}. ${d} 부터)</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <option class="add2" style="display:none" value="${monthYear.nY}-${monthYear.rM}-${monthYear.rD}">1년 (${monthYear.nY}. ${monthYear.rM}. ${monthYear.rD})</option>
                            <option class="add2" style="display:none" value="${monthYear.nNY}-${monthYear.rM}-${monthYear.rD}">2년 (${monthYear.nNY}. ${monthYear.rM}. ${monthYear.rD})</option>
                        </select>
                    </div>
                </div>
                <div class="nac-row">
                    <div class="row-in-select">
                        <label>계좌개설목적</label>
                        <select id="ac_purpose" name="ac_purpose" class="form-control margin-bottom-20">
                            <option class="add1" value="예금">예금</option>
                            <option class="add1" value="급여">급여</option>
                            <option class="add1" value="생활비">생활비</option>
                            <option class="add2" style="display:none" value="적금">적금</option>
                        </select>
                    </div>
                </div>
                <div class="nac-btn-row">
                    <div class="nac-btn-group">
                        <button type="button" class="nac-submit" onclick="nacSubmit()">계좌개설</button>
                        <button type="button" class="nac-cancel" onclick="nacCancel()">취소</button>
                    </div>
                    <div class="nac-psC-pTag3"></div>
                </div>
            </form>
        </div>
    </div>
</body>

<script src="/js/newAccount.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>