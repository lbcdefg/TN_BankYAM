<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" type="text/css" href="/css/chatList.css" />
<script>
	function listPlus(){
		const item = document.createElement("li");
		item.classList.add("album-table-content")
		item.innerHTML = `<span class="alarmCount">3</span>
		<a onClick="window.open(this.href, '', 'width=400, height=500'); return false;" class="album-table-img">
		<img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
		<dl>
			<dt>
				<a onClick="window.open(this.href, '', 'width=400, height=500'); return false;" class="album-table-sub" title="채팅방이름">
				채팅방 이름</a>
			</dt>
			<dd>마지막 대화</dd>
			<dd>마지막 대화 시간</dd>
		</dl>`;
		document.querySelector(".album-table-list").append(item);
	}
</script>
<body>
<%@ include file="/WEB-INF/views/nav.jsp" %>
<div class="body-main">
    <div class="chat-buttons">
        <ul class="button-list">
            <li><a href="/board/list.do">마지막 대화 시간</a></li>
            <li><a href="/board/list.do">채팅방 이름</a></li>
            <li class="active"><a>글쓰기</a></li>
        </ul>
    </div>
    <div class="album-table">
        <ul class="album-table-list">
            <li class="album-table-content">
                <span class="alarmCount">3</span>
                <a onClick="window.open('room', '', 'width=400, height=500'); return false;" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a onClick="window.open('room', '', 'width=400, height=500'); return false;" class="album-table-sub" title="채팅방이름">
                        채팅방 이름</a>
                    </dt>
                    <dd>마지막 대화</dd>
                    <dd>마지막 대화 시간</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=9" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=9" class="album-table-sub" title="제목9">
                        제목9</a>
                    </dt>
                    <dd>우</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=8" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=8" class="album-table-sub" title="제목8">
                        제목8</a>
                    </dt>
                    <dd>박</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=7" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=7" class="album-table-sub" title="제목7">
                        제목7</a>
                    </dt>
                    <dd>우</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=6" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=6" class="album-table-sub" title="제목6">
                        제목6</a>
                    </dt>
                    <dd>이</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=5" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=5" class="album-table-sub" title="제목5">
                        제목5</a>
                    </dt>
                    <dd>박</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=4" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=4" class="album-table-sub" title="제목4">
                        제목4</a>
                    </dt>
                    <dd>이</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=3" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=3" class="album-table-sub" title="제목3">
                        제목3</a>
                    </dt>
                    <dd>우</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=2" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=2" class="album-table-sub" title="제목2">
                        제목2</a>
                    </dt>
                    <dd>박</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
            <li class="album-table-content">
                <div class="alarmCount"></div>
                <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=1" class="album-table-img">
                <img style="vertical-align:top; border:none" src="css/imgs/NoImage.png"></a>
                <dl>
                    <dt>
                        <a href="postcontent?cp=1&amp;ps=12&amp;cat=all&amp;bt=album&amp;postId=1" class="album-table-sub" title="제목1">
                        제목1</a>
                    </dt>
                    <dd>우</dd>
                    <dd>15:28&nbsp;&nbsp;조회수 0</dd>
                </dl>
            </li>
        </ul>
    </div>
    <div onclick="listPlus()" class="listPlus"><div class="listPlus-text">더 보기 +</div></div>
</div>
</body>
<%@ include file="/WEB-INF/views/footer.jsp" %>