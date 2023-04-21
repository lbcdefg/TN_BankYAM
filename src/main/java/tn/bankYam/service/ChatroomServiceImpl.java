package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tn.bankYam.dto.*;
import tn.bankYam.mapper.ChatroomMapper;
import tn.bankYam.mapper.MemberyMapper;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Service
public class ChatroomServiceImpl implements ChatroomService{
	@Autowired
	private ChatroomMapper chatroomMapper;

	@Autowired
	private MemberyMapper memberyMapper;



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

	@Override
	public List<Membery> selectChatMemberS(long cr_seq) {
		return chatroomMapper.selectChatMember(cr_seq);
	}

	@Override
	public long makeRoomS(Membery membery, List<Long> f_mb_seq_list) {
		
		//채팅방 만들기
		Chatroom chatroom = new Chatroom();
		String cr_name = membery.getMb_name() + " ";
		for(Long f_mb_seq : f_mb_seq_list){
			cr_name += memberyMapper.findBySeq(f_mb_seq).getMb_name() + " ";
		}
		chatroom.setCr_name(cr_name);
		chatroomMapper.insertRoom(chatroom);
		System.out.println(chatroom.getCr_seq());
		
		//만든 채팅방에 나 추가하기
		Chatmember chatmemberMy = new Chatmember();
		chatmemberMy.setCm_cr_seq(chatroom.getCr_seq());
		chatmemberMy.setCm_mb_seq(membery.getMb_seq());
		chatroomMapper.insertMember(chatmemberMy);
		
		//만든 채팅방에 친구 추가하기
		for(Long f_mb_seq : f_mb_seq_list){
			Chatmember chatmember = new Chatmember();
			chatmember.setCm_cr_seq(chatroom.getCr_seq());
			chatmember.setCm_mb_seq(f_mb_seq);
			chatroomMapper.insertMember(chatmember);
		}
		return chatroom.getCr_seq();
	}

	@Override
	public Chatroom selectRoomS(long cr_seq) {
		return chatroomMapper.selectRoom(cr_seq);
	}

	@Override
	public List<Chatcontent> selectContentS(long cr_seq) {
		return chatroomMapper.selectContent(cr_seq);
	}

	@Override
	public List<Chatfile> selectFilesS(long cr_seq) {
		return chatroomMapper.selectFiles(cr_seq);
	}

	@Override
	public Chatcontent insertContentS(Chatcontent chatcontent) {
		chatroomMapper.insertContent(chatcontent);
		return chatcontent;
	}

	@Override
	public Chatcontent selectContentBySeqS(long cc_seq) {
		return chatroomMapper.selectContentBySeq(cc_seq);
	}


}
