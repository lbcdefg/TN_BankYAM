package tn.bankYam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import tn.bankYam.dto.Chatcontent;
import tn.bankYam.dto.Chatfile;
import tn.bankYam.dto.Chatmember;
import tn.bankYam.dto.Chatroom;

import java.util.HashMap;
import java.util.List;

@Mapper
@Repository
public interface ChatroomMapper {
	List<Chatroom> selectChatRoom(long mb_seq);
	Chatmember checkRoom(HashMap<String, Long> map);
	void insertRoom(Chatroom chatroom);
	void insertMember(Chatmember chatmember);
	Chatroom selectRoom(long cr_seq);
	List<Chatcontent> selectContent(long cr_seq);
	List<Chatfile> selectFiles(long cr_seq);
}
