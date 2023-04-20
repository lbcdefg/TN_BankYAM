<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/accounts.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam Friends</title>
</head>

<body>
    <div class="acs-frame body-main">
        <c:if test="${not empty membery}">
            <p class="acs-title fontS-35">${membery.mb_name} 님의 계좌</p>
        </c:if>

        <!-- 사용중/휴면 계좌들 관리 -->
        <div class="acs-table-size350">
            <table class="acs-list-table">
                <tr class="acs-list-head">
                    <th class="acs-list-5"></th>
                    <th class="acs-list-18">계좌번호</th>
                    <th class="acs-list-18">계좌별칭</th>
                    <th class="acs-list-12">주 계좌설정</th>
                    <th class="acs-list-10">계좌상태</th>
                    <th class="acs-list-10">휴면전환</th>
                    <th class="acs-list-10">해지신청</th>
                    <th class="acs-list-10">계좌생성일</th>
                </tr>
                <c:if test="${empty acList}">
                    <tr class="acs-list-row" style="border:none; height:400px">
                        <td class="fontS-35" align='center' colspan="6">계좌가 없습니다.. 불가능할텐데.. 왜죠!?</td>
                    </tr>
                </c:if>
                <c:forEach items="${acList}" var="ac">
                    <tr class="acs-list-row">
                        <td class="acs-list-5 acm" id="${ac.ac_seq}" name="${ac.ac_main}">${ac.ac_main}</td>
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
                        <td class="acs-list-20">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}</td>
                        <td class="acs-list-23"><span class="acn">${ac.ac_name}</span><div class="acs-nameM-btnDiv"><button type="button" class="acs-nameM-btn" onclick="modifyName('${ac.ac_name}',${ac.ac_seq})">수정</button></div></td>
                        <td class="acs-list-12">
                            <c:if test="${ac.ac_status == '사용중'}">
                                <input type="radio" name="acr" id="acr-${ac.ac_seq}"/>
                            </c:if>
                        </td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-10">
                            <c:if test="${ac.ac_status == '사용중'}">
                                <a class="acs-click" onclick="">휴면신청</a>
                            </c:if>
                            <c:if test="${ac.ac_status == '휴면'}">
                                <a class="acs-click" onclick="">휴면취소</a>
                            </c:if>
                        </td>
                    <c:if test="${ac.ac_status == '사용중' or ac.ac_status == '휴면'}">
                        <td class="acs-list-10"><a class="acs-click" onclick="">해지신청</a></td>
                    </c:if>
                        <td class="acs-list-10">${ac.ac_rdate}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- 해지한 계좌들 관리 -->
        <div class="acs-table-size300 marginTop100">
            <table class="acs-list-table">
                <tr class="acs-list-head">
                    <th class="acs-list-5"></th>
                    <th class="acs-list-20">계좌번호</th>
                    <th class="acs-list-23">계좌별칭</th>
                    <th class="acs-list-12">복구문의</th>
                    <th class="acs-list-10">계좌상태</th>
                    <th class="acs-list-20">해지일자</th>
                    <th class="acs-list-10">계좌생성일</th>
                </tr>
                <c:if test="${empty acXList}">
                    <tr class="acs-list-row" style="border:none; height:400px">
                        <td class="fontS-35" align='center' colspan="7">해지하신 계좌내역이 없습니다.</td>
                    </tr>
                </c:if>
                <c:forEach items="${acXList}" var="ac">
                    <tr class="acs-list-row">
                        <td class="acs-list-5 acm" id="${ac.ac_seq}" name="${ac.ac_main}">${ac.ac_main}</td>
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
                        <td class="acs-list-20">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}</td>
                        <td class="acs-list-23"><span class="acn">${ac.ac_name}</span><div class="acs-nameM-btnDiv"><button type="button" class="acs-nameM-btn" onclick="modifyName('${ac.ac_name}',${ac.ac_seq})">수정</button></div></td>
                        <td class="acs-list-12">
                            <c:if test="${ac.ac_status == '해지'}">
                                <a class="acs-click" onclick="">복구신청</a>
                            </c:if>
                            <c:if test="${ac.ac_status == '복구신청'}">
                                <a class="acs-click" onclick="">복구취소</a>
                            </c:if>
                        </td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-20">${ac.ac_xdate}</td>
                        <td class="acs-list-10">${ac.ac_rdate}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>

        <!-- 계좌 별칭 설정 mini 새 창 -->
        <div class="acs-nameM">
            <div class="acs-nameM-body">
                <h2 style="font-size: 30px; color:#F7F3EF; margin-bottom:10%">계좌별칭 설정</h2>
                <form name="acnf" method="post" action="accounts_nameC">
                    <input type="text" class="ac-name" name="ac_name" maxlength="15" spellcheck="false"/>
                    <input type="hidden" class="ac-receptor"/>
                    <input type="hidden" class="ac-receptor2" name="ac_seq"/>
                    <input type="button" class="acs-nameMA-btn acs-click" onclick="modifySubmit()" value="변경"/>&nbsp;
                    <input type="button" class="acs-nameMC-btn acs-click" onclick="modifyCancle()" value="취소">
                </form>
                <div class="acs-nameM-ps">
                </div>
            </div>
        </div>

    </div>
</body>

<script src="/js/accounts.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>