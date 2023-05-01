package tn.bankYam.service;

import org.springframework.web.multipart.MultipartFile;
import tn.bankYam.dto.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public interface ChatroomService {
	List<Chatroom> selectChatRoomS(long mb_seq);
	Chatmember checkRoomS(long mb_seq, long f_f_mb_seq);
	List<Membery> selectChatMemberS(long cr_seq);
	long makeRoomS(Membery membery, List<Long> f_mb_seq);
	void insertMemberS(Chatmember chatmember);
	Chatroom selectRoomS(long cr_seq);
	List<Chatcontent> selectContentS(long cr_seq);
	List<Chatfile> selectFilesS(long cr_seq);
	Chatcontent insertContentS(Chatcontent chatcontent);
	Chatcontent selectContentBySeqS(long cc_seq);
	void insertStatusS(Chatstatus chatstatus);
	void deleteStatusS(long mb_seq, long cr_seq);
	List<Chatcontent> selectStatusCount(long cr_seq);
	long outChat(Membery membery, long cr_seq);
	long insertFileS(MultipartFile file) throws IOException;
	Chatfile selectFileBySeqS(long cf_seq);
	void updateRoomNameS(Chatroom chatroom);
}
