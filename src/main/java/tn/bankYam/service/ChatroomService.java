package tn.bankYam.service;

import tn.bankYam.dto.Chatmember;
import tn.bankYam.dto.Chatroom;

import java.util.HashMap;
import java.util.List;

public interface ChatroomService {
	List<Chatroom> selectChatRoomS(long mb_seq);
	Chatmember checkRoomS(long mb_seq, long f_mb_seq);
}
