package tn.bankYam.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Chatcontent;
import tn.bankYam.dto.Chatstatus;
import tn.bankYam.dto.Membery;
import tn.bankYam.utils.ServerEndpointConfigurator;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;

@RequiredArgsConstructor
@Service
@ServerEndpoint(value="/chat/soket/room", configurator = ServerEndpointConfigurator.class)
public class ChatRoomWebSocket {
	private static Set<Session> clients =
			Collections.synchronizedSet(new HashSet<>());
	private Map<Session, EndpointConfig> configs = Collections.synchronizedMap(new HashMap<>());

	private final ChatroomService chatroomService;
	private final MemberyService memberyService;

	@OnMessage
	public void onMessage(String data, Session session) throws Exception{
		ObjectMapper mapper = new ObjectMapper();

		//메시지 입력 받으면
		//이안에서 디비에 채팅창내용 저장하기

		HashMap<String, Object> dataMap = mapper.readValue(data, HashMap.class);
		Chatcontent chatcontent = new Chatcontent();

		List<Membery> chatMemberList = chatroomService.selectChatMemberS(Long.parseLong((String) dataMap.get("cc_cr_seq")));
		String jsonInString = "";

		if(!dataMap.get("type").equals("inChat")){
			if (dataMap.get("type").equals("sendMsg")) {
				chatcontent.setCc_content((String) dataMap.get("cc_content"));
				chatcontent.setCc_cr_seq(Long.parseLong((String) dataMap.get("cc_cr_seq")));
				chatcontent.setCc_mb_seq(Long.parseLong((String) dataMap.get("cc_mb_seq")));

				chatcontent = chatroomService.insertContentS(chatcontent);
			} else if (dataMap.get("type").equals("deleteChat")) {//채팅내용이 없으면 채팅 나가기
				long cc_seq = chatroomService.outChat(memberyService.findBySeq(Long.parseLong((String) dataMap.get("cc_mb_seq"))),
						Long.parseLong((String) dataMap.get("cc_cr_seq")));
				chatcontent.setCc_seq(cc_seq);
			} else if (dataMap.get("type").equals("inFile")){
				chatcontent.setCc_seq(Long.parseLong((String) (""+dataMap.get("cc_seq"))));
			}
			chatcontent = chatroomService.selectContentBySeqS(chatcontent.getCc_seq());
			chatcontent.setCc_status_count(chatMemberList.size() - 1);
			jsonInString = mapper.writeValueAsString(chatcontent);

			for (Membery membery : chatMemberList) {
				System.out.println(membery);
				Chatstatus chatstatus = new Chatstatus();
				chatstatus.setCs_cc_seq(chatcontent.getCc_seq());
				chatstatus.setCs_mb_seq(membery.getMb_seq());
				chatroomService.insertStatusS(chatstatus);
			}

		}else {
			chatcontent.setCc_cr_seq(Long.parseLong((String) dataMap.get("cc_cr_seq")));
			chatcontent.setCc_mb_seq(Long.parseLong((String) dataMap.get("cc_mb_seq")));

			HashMap<String, Object> temp = new HashMap<>();
			temp.put("inChat", "inChat");
			temp.put("cc_cr_seq", chatcontent.getCc_cr_seq());
			jsonInString = mapper.writeValueAsString(temp);
		}

		//세션인원중에 보내기
		for(Session s : clients) {
			System.out.println("send data : " + chatcontent.getCc_content());
			EndpointConfig config = configs.get(s);
			// HttpSessionConfigurator에서 설정한 session값을 가져온다.
			HttpSession httpSession = (HttpSession) config.getUserProperties().get(ServerEndpointConfigurator.Session);
			System.out.println((Membery)httpSession.getAttribute("membery"));
			Iterator<Membery> iterator = chatMemberList.iterator();
			while(iterator.hasNext()){
				if(((Membery) httpSession.getAttribute("membery")).getMb_seq() == iterator.next().getMb_seq()){
					s.getBasicRemote().sendText(jsonInString);
					iterator.remove();
				}
			}
		}

	}

	@OnOpen
	public void onOpen(Session s, EndpointConfig config) {
		//세션에 연결됫을때 이 채팅창안에잇는 내가 안읽엇던것들 다 읽음표시하기
		System.out.println("open session : " + s.toString());
		if(!clients.contains(s)) {
			clients.add(s);
			configs.put(s, config);
			System.out.println("session open : " + s);
		}else {
			System.out.println("이미 연결된 session 임!!!");
		}
	}

	@OnClose
	public void onClose(Session s) {
		//이건.. 언제?
		System.out.println("session close : " + s);
		clients.remove(s);
	}
}
