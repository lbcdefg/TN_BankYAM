package tn.bankYam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("chat")
public class ChatController {
	@GetMapping("list")
	public String chatList(){
		return "chatList";
	}

	@GetMapping("room")
	private String chatRoom(){
		return "chatRoom";
	}
}
