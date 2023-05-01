package tn.bankYam.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import tn.bankYam.dto.*;
import tn.bankYam.mapper.ChatroomMapper;
import tn.bankYam.mapper.MemberyMapper;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service
public class ChatroomServiceImpl implements ChatroomService{
	@Autowired
	private ChatroomMapper chatroomMapper;

	@Autowired
	private MemberyMapper memberyMapper;

	@Value("${file.dir.upload}")
	private String fileDir;



	@Override
	public List<Chatroom> selectChatRoomS(long mb_seq) {
		return chatroomMapper.selectChatRoom(mb_seq);
	}

	@Override
	public Chatmember checkRoomS(long mb_seq, long f_f_mb_seq) {
		HashMap<String, Long> map = new HashMap<>();
		map.put("mb_seq", mb_seq);
		map.put("f_f_mb_seq", f_f_mb_seq);
		return chatroomMapper.checkRoom(map);
	}

	@Override
	public List<Membery> selectChatMemberS(long cr_seq) {
		return chatroomMapper.selectChatMember(cr_seq);
	}

	@Override
	@Transactional
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
		Chatcontent chatcontentMy = new Chatcontent();
		chatcontentMy.setCc_cr_seq(chatroom.getCr_seq());
		chatcontentMy.setCc_content(membery.getMb_name() + "님이 입장하였습니다.");
		chatroomMapper.insertContent(chatcontentMy);
		
		//만든 채팅방에 친구 추가하기
		for(Long f_mb_seq : f_mb_seq_list){
			Chatmember chatmember = new Chatmember();
			chatmember.setCm_cr_seq(chatroom.getCr_seq());
			chatmember.setCm_mb_seq(f_mb_seq);
			chatroomMapper.insertMember(chatmember);

			Membery chatMember = memberyMapper.findBySeq(f_mb_seq);
			Chatcontent chatcontent = new Chatcontent();
			chatcontent.setCc_cr_seq(chatroom.getCr_seq());
			chatcontent.setCc_content(chatMember.getMb_name() + "님이 입장하였습니다.");
			chatroomMapper.insertContent(chatcontent);
		}
		return chatroom.getCr_seq();
	}

	@Override
	public void insertMemberS(Chatmember chatmember) {
		chatroomMapper.insertMember(chatmember);

		Membery chatMember = memberyMapper.findBySeq(chatmember.getCm_mb_seq());
		Chatcontent chatcontent = new Chatcontent();
		chatcontent.setCc_cr_seq(chatmember.getCm_cr_seq());
		chatcontent.setCc_content(chatMember.getMb_name() + "님이 입장하였습니다.");
		chatroomMapper.insertContent(chatcontent);
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

	@Override
	public void insertStatusS(Chatstatus chatstatus) {
		chatroomMapper.insertStatus(chatstatus);
	}

	@Override
	public void deleteStatusS(long mb_seq, long cr_seq) {
		HashMap<String, Long> map = new HashMap<>();
		map.put("mb_seq", mb_seq);
		map.put("cr_seq", cr_seq);
		chatroomMapper.deleteStatus(map);
	}

	@Override
	public List<Chatcontent> selectStatusCount(long cr_seq) {
		return chatroomMapper.selectStatusCount(cr_seq);
	}

	@Override
	@Transactional
	public long outChat(Membery membery, long cr_seq) {
		Chatcontent chatcontent = new Chatcontent();
		chatcontent.setCc_cr_seq(cr_seq);
		chatcontent.setCc_content(membery.getMb_name() + "님이 퇴장하였습니다.");
		chatroomMapper.insertContent(chatcontent);
		Chatmember chatmember = new Chatmember();
		chatmember.setCm_cr_seq(cr_seq);
		chatmember.setCm_mb_seq(membery.getMb_seq());
		chatroomMapper.deleteOutChat(chatmember);
		return chatcontent.getCc_seq();
	}

	@Override
	public long insertFileS(MultipartFile file) throws IOException {
		String origName = file.getOriginalFilename(); // 원래 파일 이름 추출
		String uuid = UUID.randomUUID().toString(); // 파일 이름으로 쓸 uuid 생성
		String extension = origName.substring(origName.lastIndexOf(".")); // 확장자 추출(ex : .png)
		String savedName = uuid + extension; // uuid와 확장자 결합
		String savedPath = fileDir + savedName; // 파일을 불러올 때 사용할 파일 경로

		// 파일 경로 생성
		Path uploadPath = Paths.get(fileDir, savedName);
		// 파일 저장
		Files.write(uploadPath, file.getBytes());

		//file.transferTo(new File(savedPath));
		//savedPath=savedPath.substring(savedPath.lastIndexOf("/file"));
		//file.transferTo(new File(savedPath)); // 실제로 로컬에 uuid를 파일명으로 저장

		Chatfile chatfile = new Chatfile();
		chatfile.setCf_orgnm(origName);
		chatfile.setCf_savednm(savedName);
		chatfile.setCf_savedpath(savedPath);

		chatroomMapper.insertFile(chatfile);
		return chatfile.getCf_seq();
	}

	@Override
	public Chatfile selectFileBySeqS(long cf_seq) {
		return chatroomMapper.selectFileBySeq(cf_seq);
	}

	@Override
	public void updateRoomNameS(Chatroom chatroom) {
		chatroomMapper.updateRoomName(chatroom);
	}


}
