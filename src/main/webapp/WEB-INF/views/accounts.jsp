<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="/WEB-INF/views/nav.jsp" %>

<head>
    <link href="/css/accounts.css" rel="stylesheet" type="text/css">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>BankYam Accounts</title>
</head>

<body>
    <div class="acs-frame body-main">
        <div class="acs-body-head">
        <c:if test="${not empty membery}">
            <p class="acs-title fontS-35">${membery.mb_name} 님의 계좌</p>
            <button class="new-ac-btn" onclick="location.href='newAccount'">새 계좌 개설</button>
        </c:if>
        </div>

        <!-- 사용중/휴면 계좌들 관리 -->
        <div class="acs-table-size350">
            <table class="acs-list-table">
                <tr class="acs-list-head">
                    <th class="acs-list-5"></th>
                    <th class="acs-list-17">계좌번호</th>
                    <th class="acs-list-17">계좌별칭</th>
                    <th class="acs-list-11">주 계좌설정</th>
                    <th class="acs-list-10">계좌상태</th>
                    <th class="acs-list-10">휴면전환</th>
                    <th class="acs-list-10">해지신청</th>
                    <th class="acs-list-10">비밀번호 변경</th>
                    <th class="acs-list-10">계좌생성일</th>
                </tr>
                <c:if test="${empty acList}">
                    <tr class="acs-list-row" style="border:none; height:200px">
                        <td class="fontS-25" align='center' colspan="6">계좌가 없습니다.. 불가능할텐데.. 왜죠!?</td>
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
                        <td class="acs-list-27">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}
                        <br><span class="fontS-12 color-B39273">잔액: <fmt:formatNumber var="bal" value="${ac.ac_balance}" pattern="#,###" /> ${bal}원</span></td>
                        <td class="acs-list-17"><span class="acn">${ac.ac_name}</span><div class="acs-nameM-btnDiv"><button type="button" class="acs-nameM-btn" onclick="modifyName('${ac.ac_name}',${ac.ac_seq})">수정</button></div></td>
                        <td class="acs-list-11">
                            <c:if test="${ac.ac_status == '사용중'}">
                                <input type="radio" name="acr" id="acr-${ac.ac_seq}"/>
                            </c:if>
                        </td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-10">
                            <c:if test="${ac.ac_main == '주'}">
                                <span style="float:right; font-size:12px"> 주 계좌는 휴면<span>&nbsp;
                            </c:if>
                            <c:if test="${ac.ac_main != '주'}">
                                <c:if test="${ac.ac_status == '사용중'}">
                                    <a class="acs-click" onclick="acCheck('휴면신청',${ac.ac_seq})">휴면신청</a>
                                </c:if>
                                <c:if test="${ac.ac_status == '휴면'}">
                                    <a class="acs-click" onclick="acCheck('휴면취소',${ac.ac_seq})">휴면취소</a>
                                </c:if>
                            </c:if>
                        </td>
                        <td class="acs-list-10">
                        <c:if test="${ac.ac_main == '주'}">
                            <span style="float:left; font-size:12px">또는 해지 불가<span>
                        </c:if>
                        <c:if test="${ac.ac_main != '주'}">
                            <c:if test="${ac.ac_status == '사용중' or ac.ac_status == '휴면'}">
                                <a class="acs-click" onclick="acCheck2('해지신청','${bal}',${ac.ac_seq}, ${ac.ac_balance})">해지신청</a>
                            </c:if>
                        </c:if>
                        </td>
                        <td class="acs-list-10">
                        <c:if test="${ac.ac_status == '사용중'}">
                            <a class="acs-click" onclick="modifyPs(${ac.ac_seq})">변경</a>
                        </c:if>
                        </td>
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
                    <th class="acs-list-17">계좌번호</th>
                    <th class="acs-list-17">계좌별칭</th>
                    <th class="acs-list-11">복구문의</th>
                    <th class="acs-list-10">계좌상태</th>
                    <th class="acs-list-10">계좌삭제</th>
                    <th class="acs-list-20">해지일자</th>
                    <th class="acs-list-10">계좌생성일</th>
                </tr>
                <c:if test="${empty acXList}">
                    <tr class="acs-list-row" style="border:none; height:200px">
                        <td class="fontS-25" align='center' colspan="7">해지하신 계좌내역이 없습니다.</td>
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
                        <td class="acs-list-17">${firstAcSeq}-${secondAcSeq}-${mainAcSeq}-${lastAcSeq}
                        <br><span class="fontS-12 color-B39273">잔액: <fmt:formatNumber var="bal" value="${ac.ac_balance}" pattern="#,###" /> ${bal}원</span></td>
                        <td class="acs-list-17"><span class="acn">${ac.ac_name}</span><div class="acs-nameM-btnDiv"><button type="button" class="acs-nameM-btn" onclick="modifyName('${ac.ac_name}',${ac.ac_seq})">수정</button></div></td>
                        <td class="acs-list-11">
                            <c:if test="${ac.ac_status == '해지'}">
                                <a class="acs-click" onclick="acCheck('복구신청',${ac.ac_seq})">복구신청</a>
                            </c:if>
                            <c:if test="${ac.ac_status == '복구중'}">
                                <a class="acs-click" onclick="acCheck('복구취소',${ac.ac_seq})">복구취소</a>
                            </c:if>
                        </td>
                        <td class="acs-list-10">${ac.ac_status}</td>
                        <td class="acs-list-10"><a class="acs-click" onclick="acCheck2('${ac.ac_status}','${bal}',${ac.ac_seq}, ${ac.ac_balance})">계좌삭제</a></td>
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
                    <input type="text" class="ac-name" name="ac_name" maxlength="15" spellcheck="false" autocomplete='off'/>
                    <input type="hidden" class="ac-receptor1"/>
                    <input type="hidden" class="ac-receptor2" name="ac_seq"/>
                    &nbsp;
                    <input type="button" class="acs-nameMA-btn acs-click" onclick="modifySubmit()" value="변경"/>&nbsp;
                    <input type="button" class="acs-nameMC-btn acs-click" onclick="modifyCancel()" value="취소">
                </form>
                <div class="acs-nameM-ps">
                </div>
            </div>
        </div>

        <!-- 계좌 비밀번호 변경 mini 새 창 -->
        <div class="acs-psM">
            <div class="acs-psM-body">
                <h2 style="font-size: 30px; color:#F7F3EF; margin-bottom:10%">계좌 비밀번호 변경</h2>
                <div class="acs-psM-inputGroup">
                    <div style="width:100%; height:30px">
                        <span class="fontS-15 color-F7F3EF">기존 비밀번호 </span>&nbsp;
                        <input type="password" pattern="[0-9]*" class="ac-ps" maxlength="4" spellcheck="false" autocomplete='off'/>&nbsp;
                        <input type="button" class="acs-psMA-btn acs-click" onclick="psCheck()" value="확인"/>
                    </div>
                    <div class="acs-psM-ps1"></div>
                    <form name="acpf" method="post" action="accounts_psChange">
                        <div style="width:100%; height:30px">
                            <span class="fontS-15 color-F7F3EF">신규 비밀번호 </span>&nbsp;
                            <input type="password" pattern="[0-9]*" class="ac-newPs" name="ac_pwd" maxlength="4" spellcheck="false" autocomplete='off' disabled/>
                        </div>
                        <div class="acs-psM-ps2"></div>
                        <div style="width:100%; height:30px">
                            <span class="fontS-15 color-F7F3EF">비밀번호 확인 </span>&nbsp;
                            <input type="password" pattern="[0-9]*" class="ac-newPs-check" maxlength="4" spellcheck="false" autocomplete='off' disabled/>
                        </div>
                        <div class="acs-psM-ps3"></div>
                        <input type="hidden" class="ac-receptor" name="ac_seq"/>
                        <div class="acs-psM-btnGroup">
                            <input type="button" class="acs-psMA-btn acs-click" onclick="psSubmit()" value="변경"/>&nbsp;
                            <input type="button" class="acs-psMC-btn acs-click" onclick="psCancel()" value="취소">
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- 계좌 비밀번호 체크 mini 새 창 -->
        <div class="acs-psC">
            <div class="acs-psC-body">
                <h2 style="font-size: 30px; color:#F7F3EF; margin-bottom:10%">계좌 비밀번호 확인</h2>
                <div class="acs-psC-inputGroup">
                    <input type="hidden" class="ac-receptor1"/>
                    <input type="hidden" class="ac-receptor2"/>
                    <div style="width:100%; height:30px">
                        <span class="fontS-15 color-F7F3EF">기존 비밀번호 </span>&nbsp;
                        <input type="password" pattern="[0-9]*" class="ac-ps-check" maxlength="4" spellcheck="false" autocomplete='off'/>&nbsp;
                        <input type="button" class="acs-psC-btn acs-click" onclick="psCCheck()" value="확인"/>
                    </div>
                    <div class="acs-psC-ps1"></div>
                    <div class="acs-psC-btnGroup">
                        <input type="button" class="acs-psCC-btn acs-click" onclick="psCCancel()" value="취소">
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

<script src="/js/accounts.js"></script>

<%@ include file="/WEB-INF/views/footer.jsp" %>