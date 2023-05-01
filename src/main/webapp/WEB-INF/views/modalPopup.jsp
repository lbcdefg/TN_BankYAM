<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<link rel="stylesheet" type="text/css" href="/css/modalPopup.css" />
<script type="text/javascript" src="/js/modalPopup.js"></script>
<section class="modal modal-section type-confirm">
    <div class="enroll_box">
        <p class="menu_msg"></p>
    </div>
    <div class="enroll_btn">
        <button class="btn pink_btn btn_ok">확인</button>
        <button class="btn gray_btn modal_close">취소</button>
    </div>
</section>
<section class="modal modal-section type-prompt">
    <div class="enroll_box">
        <p class="menu_msg"></p>
        <input type="text" id="prompt_input">
    </div>
    <div class="enroll_btn">
        <button class="btn pink_btn btn_ok">확인</button>
        <button class="btn gray_btn modal_close">취소</button>
    </div>
</section>
<section class="modal modal-section type-alert">
    <div class="enroll_box">
        <p class="menu_msg"></p>
    </div>
    <div class="enroll_btn">
        <button class="btn pink_btn modal_close">확인</button>
    </div>
</section>