package tn.bankYam.service;

import tn.bankYam.dto.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

public interface ChatroomService {
	List<Chatroom> selectChatRoomS(long mb_seq);
	Chatmember checkRoomS(long mb_seq, long f_mb_seq);
	List<Membery> selectChatMemberS(long cr_seq);
	long makeRoomS(Membery membery, List<Long> f_mb_seq);
	Chatroom selectRoomS(long cr_seq);
	List<Chatcontent> selectContentS(long cr_seq);
	List<Chatfile> selectFilesS(long cr_seq);
	Chatcontent insertContentS(Chatcontent chatcontent);
	Chatcontent selectContentBySeqS(long cc_seq);
}
