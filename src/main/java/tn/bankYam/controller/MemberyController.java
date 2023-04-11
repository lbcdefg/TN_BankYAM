package tn.bankYam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("member")
public class MemberyController {

	@GetMapping("join.do")
	private String join(){
		return "member/join";
	}

	@GetMapping("update.do")
	public String update(){
		return "member/update";
	}
}
