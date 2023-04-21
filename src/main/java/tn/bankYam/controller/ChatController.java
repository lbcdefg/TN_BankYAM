package tn.bankYam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import tn.bankYam.dto.Chatmember;
import tn.bankYam.dto.Chatroom;
import tn.bankYam.dto.Membery;
import tn.bankYam.service.ChatroomService;
import tn.bankYam.service.FriendsService;
import tn.bankYam.utils.ScriptUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("chat")
public class ChatController {
	@Autowired
	private ChatroomService chatroomService;
	@Autowired
	private FriendsService friendsService;

	@GetMapping("list")
	public String chatList(Model model, HttpSession session, HttpServletResponse response) throws IOException {
		Membery membery = (Membery)session.getAttribute("membery");
		model.addAttribute("chatroomList", chatroomService.selectChatRoomS(membery.getMb_seq()));
		model.addAttribute("frList", friendsService.selectFrList(membery));
		//ScriptUtil.newWindow(response, "room?cr_seq="+2);
		return "chatList";
	}

	@GetMapping("room")
	public String chatRoom(long cr_seq, Model model){
		model.addAttribute("roomInfo", chatroomService.selectRoomS(cr_seq));
		model.addAttribute("contents", chatroomService.selectContentS(cr_seq));
		model.addAttribute("files", chatroomService.selectFilesS(cr_seq));
		return "chatRoom";
	}

	@GetMapping("insert")
	@ResponseBody
	public long insertRoom(@RequestParam(value = "f_mb_seq[]") ArrayList<Long> f_mb_seq, HttpSession session, HttpServletResponse response) throws IOException{
		System.out.println(f_mb_seq);
		Membery membery = (Membery) session.getAttribute("membery");
		if(f_mb_seq.size() == 1){
			Chatmember chatmember= chatroomService.checkRoomS(membery.getMb_seq(), f_mb_seq.get(0));
			if(chatmember != null){
				return chatmember.getCm_cr_seq();
			}
		}
		//채팅방 만들고 채팅인원 인서트 한번에 서비스 합시다.
		long roomNumber = chatroomService.makeRoomS(membery, f_mb_seq);
		return roomNumber;
	}

	@RequestMapping("/mychatt")
	@ResponseBody
	public ModelAndView chatt() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chatting");
		return mv;
	}
}
