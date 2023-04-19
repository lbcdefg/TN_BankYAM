package tn.bankYam.service;

import tn.bankYam.dto.Chatcontent;
import tn.bankYam.dto.Chatfile;
import tn.bankYam.dto.Chatmember;
import tn.bankYam.dto.Chatroom;

import java.util.HashMap;
import java.util.List;

public interface ChatroomService {
	List<Chatroom> selectChatRoomS(long mb_seq);
	Chatmember checkRoomS(long mb_seq, long f_mb_seq);
	long makeRoomS(long mb_seq, List<Long> f_mb_seq);
	Chatroom selectRoomS(long cr_seq);
	List<Chatcontent> selectContentS(long cr_seq);
	List<Chatfile> selectFilesS(long cr_seq);
}
