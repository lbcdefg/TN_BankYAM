package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.*;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface ChatroomMapper {
	List<Chatroom> selectChatRoom(long mb_seq);
	Chatmember checkRoom(HashMap<String, Long> map);
	List<Membery> selectChatMember(long cr_seq);
	void insertRoom(Chatroom chatroom);
	void insertMember(Chatmember chatmember);
	Chatroom selectRoom(long cr_seq);
	List<Chatcontent> selectContent(long cr_seq);
	List<Chatfile> selectFiles(long cr_seq);
	void insertContent(Chatcontent chatcontent);
	Chatcontent selectContentBySeq(long cc_seq);
	void insertStatus(Chatstatus chatstatus);
	void deleteStatus(HashMap<String, Long> map);
	List<Chatcontent> selectStatusCount(long cr_seq);
	void deleteOutChat(Chatmember chatmember);
	void insertFile(Chatfile chatfile);
	Chatfile selectFileBySeq(long cf_seq);
	void updateRoomName(Chatroom chatroom);
}
