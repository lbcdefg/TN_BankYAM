function openTrPop(other_mb_seq){
    var tr_width = '730';
    var tr_height = '730';
    var tr_left = Math.ceil(( window.screen.width - tr_width )/2);
    var tr_top = Math.ceil(( window.screen.height - tr_height )/2);
    var popup = window.open('/account/transfer?other_mb_seq='+other_mb_seq,'transfer', 'width='+ tr_width +', height='+ tr_height +', left=' + tr_left + ', top='+ tr_top);
}


$("#wrap").scrollTop($("#wrap")[0].scrollHeight);
const modal = document.querySelector('.modal-member-add');
const btnClosePopup = document.querySelector('.add-close');

btnClosePopup.addEventListener('click', () => {
    modal.classList.toggle('show');
});

$(document).ready(function(){
    $("input[name=mb_email]").click(function(){
        var checkedId = $("input[name=mb_email]:checked").attr("id");
        alert(checkedId)
        $("#fr-" + checkedId).attr("style", "background-color:yellow");
    });
});

function updateChatName(cr_name){
    var form = document.createElement("form");
    form.setAttribute("action", "updateName");

    var cr_seq_input = document.createElement("input");
    cr_seq_input.setAttribute("type", "hidden");
    cr_seq_input.setAttribute("name", "cr_seq");
    cr_seq_input.setAttribute("value", cr_seq);
    form.appendChild(cr_seq_input);

    var cr_name_input = document.createElement("input");
    cr_name_input.setAttribute("type", "hidden");
    cr_name_input.setAttribute("name", "cr_name");
    cr_name_input.setAttribute("value", cr_name);
    form.appendChild(cr_name_input);

    document.body.appendChild(form);
    form.submit();
}

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

ws = new WebSocket("ws://" + location.host + "/chat/soket/room");
readContent(cr_seq);


ws.onmessage = function(msg){
    var data = JSON.parse(msg.data);
    console.log(data);

    var item;

    if(data.cc_cr_seq == cr_seq){
        if(data.inChat == null){
            if($(".chatDay").last().text() != data.cc_rdate_day){
                talk.innerHTML += '<div class="in-out-chat chatDay">' + data.cc_rdate_day + '</div>';
            }
            if(data.chatfile != null){
                $(".no-file").remove();
                item = `<a class="chat-file" href="download?cf_seq=${data.chatfile.cf_seq}">
                            <div class="file-type">`
                                //${fn:substring(data.chatfile.cf_orgnm,fn:indexOf(data.chatfile.cf_orgnm,'.')+1,fn:length(data.chatfile.cf_orgnm)) }
                item += data.chatfile.cf_orgnm.substring(data.chatfile.cf_orgnm.indexOf('.')+1, data.chatfile.cf_orgnm.length);
                item +=`    </div>
                            <span class="file-name">${data.chatfile.cf_orgnm}</span>
                        </a>`;
                $(".file-list").prepend(item);
            }
            if(data.membery == null){//누군가가 퇴장or입장
                item = `<div class="in-out-chat">${data.cc_content}</div>`
                location.reload()
            }else if(data.membery.mb_seq == mb_seq){
                if(data.chatfile != null){
                    item = `<div class="chat ch2">
                                <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                                <div class="chat-content">
                                    <div class="chat-info">
                                        <span>${data.cc_rdate_time}<br/><span class="status-count" id="sc-${data.cc_seq}">${data.cc_status_count}</span></span>
                                    </div>
                                    <div class="textbox">
                                        <a class="chat-file" href="download?cf_seq=${data.chatfile.cf_seq}">
                                            <div class="file-type">`;
                    item += data.chatfile.cf_orgnm.substring(data.chatfile.cf_orgnm.indexOf('.')+1, data.chatfile.cf_orgnm.length);
                    item +=`                </div>
                                            <span class="file-name">${data.chatfile.cf_orgnm}</span>
                                        </a>
                                    </div>
                                </div>
                            </div>`;
                }else{
                     item = `<div class="chat ch2">
                                 <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                                 <div class="chat-content">
                                     <div class="chat-info">
                                         <span>${data.cc_rdate_time}<br/><span class="status-count" id="sc-${data.cc_seq}">${data.cc_status_count}</span></span>
                                     </div>
                                     <div class="textbox">${data.cc_content}</div>
                                 </div>
                             </div>`;
                }
            }else{
                if(data.chatfile != null){
                    item = `<div class="chat ch1">
                                <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                                <div class="chat-content">
                                    <div class="chat-info">
                                        <div class="chat-name">
                                            <span>${data.membery.mb_name}</span>
                                        </div>
                                    </div>
                                    <div class="chat-text-info">
                                        <div class="textbox">
                                            <a class="chat-file" href="download?cf_seq=${data.chatfile.cf_seq}">
                                                <div class="file-type">`;
                    item += data.chatfile.cf_orgnm.substring(data.chatfile.cf_orgnm.indexOf('.')+1, data.chatfile.cf_orgnm.length);
                    item +=`                    </div>
                                                <span class="file-name">${data.chatfile.cf_orgnm}</span>
                                            </a>
                                        </div>
                                        <div class="chat-info">
                                            <span>${data.cc_rdate_time}<br/><span class="status-count" id="sc-${data.cc_seq}">${data.cc_status_count}</span></span>
                                        </div>
                                    </div>
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
            }

            talk.innerHTML += item;
            talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
            readContent(cr_seq);
        }
    }
    setTimeout(function() {
        readContent(cr_seq);
    }, 100);
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

function outChat(res){
    if(res){
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
}, 100);
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
/**
 * web socket
 */





/**
 * file upload
 */
//폼에 데이터를 추가하기 위해 (파일을 전송하기 전 정보 유지)
var fd = new FormData();
//파일 중복 업로드 방지용 맵을 선언한다.
var map = new Map();
//submit 버튼을 눌렀을 때
function submitFile(){
    //추가적으로 보낼 파라미터가 있으면 formData에 넣어준다.
    //예를들어 , 게시판의 경우 게시글 제목 , 게시글 내용 등등
    fd.append('cr_seq',cr_seq);
    fd.append('mb_seq',mb_seq);
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
        success : function(cc_seq) {
            if(cc_seq != 0) {
                data.cc_seq = cc_seq
                data.type = "inFile";
                var temp = JSON.stringify(data);
                ws.send(temp);
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
        fd = new FormData();
        console.log(files[i].name);

            fd.append("file", files[i], files[i].name);
            //파일 중복 업로드를 방지하기 위한 설정
            map.put(files[i].name, files[i].name);

            submitFile();

    }
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
        //submitFile(); //테스팅 20200108
    });
    // div 영역빼고 나머지 영역에 드래그 원래색변경
    $(document).on('dragover', function(e) {
        e.stopPropagation();
        e.preventDefault();
        objDragDrop.css('border', '2px solid green');
    });
});
function fileUpload(files){
    handleFileUpload(files);
}