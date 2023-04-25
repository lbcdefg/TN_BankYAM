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