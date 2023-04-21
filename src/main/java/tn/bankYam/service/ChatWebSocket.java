package tn.bankYam.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;
import tn.bankYam.dto.Chatcontent;
import tn.bankYam.dto.Membery;
import tn.bankYam.mapper.ChatroomMapper;
import tn.bankYam.utils.ServerEndpointConfigurator;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.*;

@RequiredArgsConstructor
@Service
@ServerEndpoint(value="/chat/soket", configurator = ServerEndpointConfigurator.class)
public class ChatWebSocket {
	private static Set<Session> clients =
			Collections.synchronizedSet(new HashSet<>());
	private Map<Session, EndpointConfig> configs = Collections.synchronizedMap(new HashMap<>());

	private final ChatroomService chatroomService;
	private final MemberyService memberyService;

	@OnMessage
	public void onMessage(String data, Session session) throws Exception{
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(data);

		//메시지 입력 받으면
		//이안에서 디비에 채팅창내용 저장하기

		HashMap<String, Object> dataMap = mapper.readValue(data, HashMap.class);
		System.out.println("dataMap : " + dataMap);
		Chatcontent chatcontent = new Chatcontent();
		chatcontent.setCc_content((String)dataMap.get("cc_content"));
		chatcontent.setCc_cr_seq(Long.parseLong((String)dataMap.get("cc_cr_seq")));
		chatcontent.setCc_mb_seq(Long.parseLong((String)dataMap.get("cc_mb_seq")));

		chatcontent = chatroomService.insertContentS(chatcontent);
		//세션인원중에 보내기

		chatcontent = chatroomService.selectContentBySeqS(chatcontent.getCc_seq());
		List<Membery> chatMemberList = chatroomService.selectChatMemberS(chatcontent.getCc_cr_seq());

		String jsonInString = mapper.writeValueAsString(chatcontent);
		System.out.println(jsonInString);
		for(Session s : clients) {
			System.out.println("send data : " + chatcontent.getCc_content());
			EndpointConfig config = configs.get(s);
			// HttpSessionConfigurator에서 설정한 session값을 가져온다.
			HttpSession httpSession = (HttpSession) config.getUserProperties().get(ServerEndpointConfigurator.Session);
			System.out.println((Membery)httpSession.getAttribute("membery"));
			s.getBasicRemote().sendText(jsonInString);
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
