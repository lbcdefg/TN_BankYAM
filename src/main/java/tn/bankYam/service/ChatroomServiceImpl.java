package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.Chatmember;
import tn.bankYam.dto.Chatroom;
import tn.bankYam.mapper.ChatroomMapper;

import java.util.HashMap;
import java.util.List;

@Service
public class ChatroomServiceImpl implements ChatroomService{
	@Autowired
	private ChatroomMapper chatroomMapper;


	@Override
	public List<Chatroom> selectChatRoomS(long mb_seq) {
		return chatroomMapper.selectChatRoom(mb_seq);
	}

	@Override
	public Chatmember checkRoomS(long mb_seq, long f_mb_seq) {
		HashMap<String, Long> map = new HashMap<>();
		map.put("mb_seq", mb_seq);
		map.put("f_mb_seq", f_mb_seq);
		return chatroomMapper.checkRoom(map);
	}


}
