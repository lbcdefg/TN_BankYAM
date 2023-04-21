/**
 * web socket
 */

function getId(id){
	return document.getElementById(id);
}

var data = {};//전송 데이터(JSON)

var ws ;
var mid = getId('mid');
var btnLogin = getId('btnLogin');
var btnSend = getId('btnSend');
var talk = getId('wrap');
var msg = getId('msg');
var msgText;
var mb_seq = getId('session_seq').value;
var cr_seq = getId('cr_seq').value;

ws = new WebSocket("ws://" + location.host + "/chat/soket");

ws.onmessage = function(msg){
    alert("여기서 채팅창 내용 받니?");
    var data = JSON.parse(msg.data);

    console.log(data);
    var item;

    if(data.membery.mb_seq == mb_seq){
         item = `<div class="chat ch2">
                     <div class="icon"><img src="${data.membery.mb_imagepath}" class="fa-solid fa-user" /></div>
                     <div class="chat-content">
                         <div class="chat-info">
                             <span>${data.cc_rdate_time}<br/><span>1</span></span>
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
                                <span>${data.cc_rdate_time}<br/><span>1</span></span>
                            </div>
                        </div>
                    </div>
                </div>`;
    }


    talk.innerHTML += item;
    talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
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
		var temp = JSON.stringify(data);
		ws.send(temp);
	}
	msg.value ='';

}