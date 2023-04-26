/**
 * web socket
 */

function getId(id){
	return document.getElementById(id);
}
function readContent(cr_seq){
    $.ajax({
        url: "readContent",
        type: "GET",
        data: {cr_seq: cr_seq},
        success: function(data){
            $(".status-count").empty();

            for(var i=0; i<data.length; i++){
                console.log(data[i]);
                $('#sc-' + data[i].cc_seq).append(data[i].cc_status_count);
            }
        },
        error: function(error){
            console.log("error: " + error);
        }
    });
}

var data = {};//전송 데이터(JSON)

var ws ;
var btnSend = getId('btnSend');
var talk = getId('wrap');
var msg = getId('msg');
var msgText;
var mb_seq = getId('session_seq').value;
var cr_seq = getId('cr_seq').value;

ws = new WebSocket("ws://" + location.host + "/chat/soket");
readContent(cr_seq);


ws.onmessage = function(msg){
    var data = JSON.parse(msg.data);

    var item;

    if(data.cc_cr_seq == cr_seq){
        if(data.inChat == null){
            if($(".chatDay").last().text() != data.cc_rdate_day){
                talk.innerHTML += '<div class="in-out-chat chatDay">' + data.cc_rdate_day + '</div>';
            }
            if(data.membery == null){//누군가가 퇴장or입장
                item = `<div class="in-out-chat">${data.cc_content}</div>`
                location.reload()
            }else if(data.membery.mb_seq == mb_seq){
                 item = `<div class="chat ch2">
                             <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                             <div class="chat-content">
                                 <div class="chat-info">
                                     <span>${data.cc_rdate_time}<br/><span class="status-count" id="sc-${data.cc_seq}">${data.cc_status_count}</span></span>
                                 </div>
                                 <div class="textbox">${data.cc_content}</div>
                             </div>
                         </div>`;
            }else{
                item = `<div class="chat ch1">
                            <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                            <div class="chat-content">
                                <div class="chat-name">
                                    <span>${data.membery.mb_name}</span>
                                </div>
                                <div class="chat-text-info">
                                    <div class="textbox">${data.cc_content}</div>
                                    <div class="chat-info">
                                        <span>${data.cc_rdate_time}<br/><span class="status-count" id="sc-${data.cc_seq}">${data.cc_status_count}</span></span>
                                    </div>
                                </div>
                            </div>
                        </div>`;
            }

            talk.innerHTML += item;
            talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
            readContent(cr_seq);
        }else{
            readContent(cr_seq);
        }
    }
}


msg.onkeyup = function(ev){
	if(ev.keyCode == 13){
        msgText = msg.value;
        console.log(msgText.slice(0, -2));
		send();
	}
}

btnSend.onclick = function(){
	msgText = msg.value;
	send();
}

function send(){
	if(msg.value.trim() != ''){
		data.cc_content = msgText;
		data.cc_cr_seq = cr_seq;
		data.cc_mb_seq = mb_seq;
		data.type = "sendMsg";
		var temp = JSON.stringify(data);
		ws.send(temp);
	}
	msg.value ='';
}

function outChat(){
    if(confirm("현재 채팅창에서 퇴장하시겠습니까? 대화내용은 모두 사라집니다.")){
        data.cc_cr_seq = cr_seq;
		data.cc_mb_seq = mb_seq;
		data.type = "deleteChat";
        var temp = JSON.stringify(data);
        ws.send(temp);
        window.close();
    }
}

function inChat(){
    data.cc_cr_seq = cr_seq;
    data.cc_mb_seq = mb_seq;
    data.type = "inChat";
    var temp = JSON.stringify(data);
    ws.send(temp);
}
setTimeout(function() {
    inChat();
}, 1000);
function chatOpen(roomNumber){
    window.open('room?cr_seq='+roomNumber, '', 'width=365, height=550');
}
function addMember(){
    if($('input:radio[name=f_f_mb_seq]').is(':checked')){
        $.ajax({
            url: "addChatMember",
            type: "GET",
            data: {cr_seq: cr_seq, f_f_mb_seq: $("input[name='f_f_mb_seq']:checked").val()},
            success: function(data){
                console.log(data);
                if(cr_seq != data){
                    chatOpen(data);
                }else if(cr_seq == 0){
                    alert("잘못된 접근입니다.")
                }
                location.reload();
            },
            error: function(error){
                console.log("error: " + error);
            }
        });
    }
}











//폼에 데이터를 추가하기 위해 (파일을 전송하기 전 정보 유지)
var fd = new FormData();
//파일 중복 업로드 방지용 맵을 선언한다.
var map = new Map();
//submit 버튼을 눌렀을 때
function submitFile(){
    //추가적으로 보낼 파라미터가 있으면 formData에 넣어준다.
    //예를들어 , 게시판의 경우 게시글 제목 , 게시글 내용 등등
    fd.append('temp',$('#temp').val());
    console.log(fd);
    //ajax로 이루어진 파일 전송 함수를 수행시킨다.
    sendFileToServer();
}
//파일 전송 함수이다.
var sendFileToServer = function() {
    $.ajax({
        type : "POST",
        url : "upload", //Upload URL
        data : fd,
        contentType : false,
        processData : false,
        cache : false,
        success : function(data) {
            if(data) {
                alert('성공');
                location.href='list.do';
            }else {
                alert('실패');
            }
        }
    });
}
function handleFileUpload(files) {
    //파일의 길이만큼 반복하며 formData에 셋팅해준다.
    var megaByte = 1024*1024;
    for (var i = 0; i < files.length; i++) {
        if(map.containsValue(files[i].name) == false && (files[i].size/megaByte) <= 20 ){
            alert(files[i].name);
            fd.append("file", files[i], files[i].name);
            //파일 중복 업로드를 방지하기 위한 설정
            map.put(files[i].name, files[i].name);
            // 파일 이름과 정보를 추가해준다.
            var tag = createFile(files[i].name, files[i].size);
            $('#fileTable').append(tag);
        }else{
            //중복되는 정보 확인 위해 콘솔에 찍음
            if((files[i].size/megaByte) > 20){
                alert(files[i].name+"은(는) \n 20메가 보다 커서 업로드가 할 수 없습니다.");
            }else{
                alert('파일 중복 : ' + files[i].name);
            }
        }
    }
}
// 태그 생성
function createFile(fileName, fileSize) {
    var file = {
        name : fileName,
        size : fileSize,
        format : function() {
            var sizeKB = this.size / 1024;
            if (parseInt(sizeKB) > 1024) {
                var sizeMB = sizeKB / 1024;
                this.size = sizeMB.toFixed(2) + " MB";
            } else {
                this.size = sizeKB.toFixed(2) + " KB";
            }
            //파일이름이 너무 길면 화면에 표시해주는 이름을 변경해준다.
            if(name.length > 70){
                this.name = this.name.substr(0,68)+"...";
            }
            return this;
        },
        tag : function() {
            var tag = new StringBuffer();
            tag.append('<tr>');
            tag.append('<td>'+this.name+'</td>');
            tag.append('<td>'+this.size+'</td>');
            tag.append("<td><button id='"+this.name+"' onclick='delFile(this)'>취소</button></td>");
            tag.append('</tr>');
            return tag.toString();
        }
    }
    return file.format().tag();
}
//업로드 할 파일을 제거할 때 수행되는 함수
function delFile(e) {
    //선택한 창의 아이디가 파일의 form name이므로 아이디를 받아온다.
    var formName = e.id;

    //form에서 데이터를 삭제한다.
    fd.delete(formName);

    //맵에서도 올린 파일의 정보를 삭제한다.
    map.remove(formName);
    // tr을 삭제하기 위해
    $(e).parents('tr').remove();
    alert('삭제 완료!');
}
$(document).ready(function() {
    var objDragDrop = $(".chat-text");
    // div 영역으로 드래그 이벤트호출
    $(".chat-text").on("dragover",
        function(e) {
            e.stopPropagation();
            e.preventDefault();
            $(this).css('border', '2px solid red');
    });
    // 해당 파일 드랍시 호출 이벤트
    $(".chat-text").on("drop", function(e) {
        $(this).css('border', '2px solid green');
        //브라우저로 이동되는 이벤트를 방지하고 드랍 이벤트를 우선시 한다.
        e.preventDefault();
        //DROP 되는 위치에 들어온 파일 정보를 배열 형태로 받아온다.
        var files = e.originalEvent.dataTransfer.files;
        //DIV에 DROP 이벤트가 발생 했을 때 다음을 호출한다.
        handleFileUpload(files);

        //sendFileToServer(); //테스팅 20200108
        submitFile(); //테스팅 20200108
    });
    // div 영역빼고 나머지 영역에 드래그 원래색변경
    $(document).on('dragover', function(e) {
        e.stopPropagation();
        e.preventDefault();
        objDragDrop.css('border', '2px solid green');
    });
});