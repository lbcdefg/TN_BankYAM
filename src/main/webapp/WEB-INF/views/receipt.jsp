<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 -->
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/transfer.css" />
 <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
 <script language="javascript">
     const regExp = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g; //전체에서 특수문자 찾기
     const blankExp = /\s/g; //전체에서 공백찾기
 </script>
 <body>
     <div class="transfer">
        <div class="transfer-inner">
         <h1 class="confirm">이체 완료</h1>
         <div class="transfer-header">
             <div class="inner">
                 <h3 class="transfer-header-title">출금정보</h3>
             </div>
         </div>
         <div class="inner">
             <div class="transfer-body">
                 <form method="post" name="f" action="transfer_ok" class="transfer-page" novalidate="novalidate">
                     
                     <div class="row">
                         <div class="row-in">
                             <label>출금계좌번호</label>
                         </div>
                     </div>
                     <div class="transfer-header">
                         <div class="inner">
                             <h3 class="transfer-header-title">입금정보</h3>
                         </div>
                     </div>
 
                     <div class="row">
                         <div class="row-in">
                             <label>입금은행</label>
                         </div>
                     </div>
 
                     <div class="row">
                         <div class="row-in">
                             <label>입금계좌번호</label>
                         </div>
                     </div>
 
                     <div class="row">
                         <div class="row-in">
                             <label>이체금액</label>
                         </div>
                     </div>
 
                     <div class="row">
                         <div class="row-in">
                             <label>통장메모</label>
                         </div>
                     </div>
                     <div class="row">
                        <div class="row-in">
                            <label>이체후잔액</label>
                        </div>
                    </div>
                     <div class="confirm">
                         <div class="">
                             <button type="button" onclick="window.close()" class="transfer-btn">확인</button>
                         </div>
                     </div>
                 </form>
             </div>
         </div>
        </div>
     </div>
 </body>
 